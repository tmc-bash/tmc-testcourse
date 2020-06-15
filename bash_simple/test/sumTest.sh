#!/usr/bin/env bats

load ./tmc/point.sh

function setup() {
  EXERCISE_PATH=`find ./ -name "src"`
  cd $EXERCISE_PATH
}

@test "addition using bc" {
  @point "1.1"

  result="$(echo 2+2 | bc)"
  [ "$result" -eq 2 ]
}

@test "addition using dc" {
  @point "1.2"

  result="$(echo 2 2+p | dc)"
  [ "$result" -eq 4 ]
}

@test "the shell script to be tested is existed" {
  @point "1.3"

  [ -f "sum.sh" ]
}

@test "sum function" {
  @point "1.4"

  run ./sum.sh 1 2 6 8
  [ "$status" -eq 0 ]
  [ "$output" = "Sum is 17." ]
}