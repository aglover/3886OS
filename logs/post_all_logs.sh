#!/bin/sh

for file in json/*
  do
    echo "Posting file: " $file
    curl -XPOST 'http://localhost:9200/device_logs/log/' --data @$file
    echo "\n"
  done