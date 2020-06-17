#!/usr/bin/env bats

load ./tmc/point.sh

function setup() {
  EXERCISE_PATH=`find ./ -name "src"`
  cd $EXERCISE_PATH
}


@test "addition using bc" {
  @point "1.1"
  result="$(echo 2+2 | bc)"

  msg "Wrong addition 1. Expected 2 but was $result."
  [ "$result" -eq 2 ]
}


@test "addition using dc" {
  @point "1.2"
  result="$(echo 2 2+p | dc)"

  msg "Wrong addition 2"
  [ "$result" -eq 4 ]
}


@test "the shell script to be tested is existed" {
  @point "1.3"
  msg "File sum.sh does not exist."
  [ -f "sum.sh" ]
}


@test "sum function" {
  @point "1.4"
  run ./sum.sh 1 2 6 8

  msg "Wrong status"
  [ "$status" -eq 0 ]
  
  msg "Wrong sum"
  [ "$output" = "Sum is 17." ]
  
}