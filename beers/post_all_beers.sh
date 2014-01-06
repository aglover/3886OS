#!/bin/sh

for file in recipes/*
  do
    echo "Posting file: " $file
    curl -XPOST 'http://localhost:9200/beer_recipes/beer/' --data @$file
    echo "\n"
  done