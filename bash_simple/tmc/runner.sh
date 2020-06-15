#/usr/bin/env bats

. ./tmc/utils.sh
# load ./tmc/utils.sh

TEST_PATH=`find ./ -name "test"`

TEST_FILES=()
for file in $TEST_PATH/*
  do
    TEST_FILES+=("$file")
done

RESULTS_FILE=".tmc_test_results.json"
if [ -e $RESULTS_FILE ]
then
  rm $RESULTS_FILE
fi

printf "[]" >> $RESULTS_FILE


TEMP_POINTS_FILE="temp_points.txt"
TEMP_RESULTS_FILE="temp_results.txt"

bats ${TEST_FILES[@]} >> $TEMP_RESULTS_FILE

# Check if points sum and tests sum match
count_points=$(< $TEMP_POINTS_FILE wc -l  )
count_results=$(head -n 1 $TEMP_RESULTS_FILE)
if [ $count_points != ${count_results:3:4} ]; then
  printf "Error: Points sum does not match tests sum. Please check again.\n"
  clear_temps
  exit 1
fi

# Get points
declare -a points_array
while IFS= read -r line
do
  points_array+=($line)
done < "$TEMP_POINTS_FILE"


# Get names and status and print to json
declare -a names_array
declare -a status_array

index=0
while read line
do
  IFS=' ' read -ra array <<< "$line"

  if grep -q '{' "$RESULTS_FILE"; then
    punc=","
  fi

  status=true
  start=3
  if [[ $line == *"not ok"* ]]; then
    status=false
    start=4
  fi
    
  name="$(cut -d' ' -f ${start}-${#array[@]} <<<"$line")"
  sed -i "s/]$/${punc}{\"name\": \"${name}\", \"points\": [\"${points_array[$index]}\"], \"status\": ${status}, \"message\": \"\", \"backtrace\": []}]/" $RESULTS_FILE

  index=$(($index+1))

done <<< "$(grep -e 'ok' $TEMP_RESULTS_FILE)"

clear_temps
