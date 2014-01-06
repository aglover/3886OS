#!/bin/sh

curl -XPUT 'http://localhost:9200/beer_recipes?pretty=true' -d @./mappings/mapping.json