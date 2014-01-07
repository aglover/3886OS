#!/bin/sh

curl -XGET 'http://localhost:9200/beer_recipes/beer/_search?pretty=true' -d @./search/search_styrian_gold_wit.json