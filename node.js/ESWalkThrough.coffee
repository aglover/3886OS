ElasticSearchClient = require 'elasticsearchclient'

serverOptions = { host: 'localhost', port: 9200 }
client = new ElasticSearchClient(serverOptions)

# http://beerrecipes.org/showrecipe.php?recipeid=729
# beer_1 = {
# 	name: "Todd Enders' Witbier",
# 	style: "wit, Belgian ale, wheat beer",
# 	ingredients: "4.0 lbs Belgian pils malt, 4.0 lbs raw soft red winter wheat, 0.5 lbs rolled oats, 0.75 oz coriander, freshly ground Zest from two table oranges and two lemons, 1.0 oz 3.1% AA Saaz, 3/4 corn sugar for priming, Hoegaarden strain yeast"
# }

# client.index('beer_recipes', 'beer', beer_1).on('data', (data) ->
# 	console.log(data)
# ).exec()


# # http://beerrecipes.org/showrecipe.php?recipeid=725
# beer_2 = {
# 	name: "Wit",
# 	style: "wit, Belgian ale, wheat beer",
# 	ingredients: "4 lbs DeWulf-Cosyns 'Pils' malt, 3 lbs brewers' flaked wheat (inauthentic; will try raw wheat nest time), 6 oz rolled oats, 1 oz Saaz hops (3.3% AA), 0.75 oz bitter (Curacao) orange peel quarters (dried), 1 oz sweet orange peel (dried), 0.75 oz coriander (cracked), 0.75 oz anise seed, one small pinch cumin, 0.75 cup corn sugar (priming), 10 ml 88% food-grade lactic acid (at bottling), BrewTek 'Belgian Wheat' yeast"
# }

# client.index('beer_recipes', 'beer', beer_2).on('data', (data) ->
# 	console.log(data)
# ).exec()

query = { "query" : { "term" : { "ingredients" : "lemons" } } }

client.search('beer_recipes', 'beer', query).on('data', (data) ->
	data = JSON.parse(data)
	# console.log(data)
	# console.log(data.hits)
	for doc in data.hits.hits
		# console.log doc._source
		# console.log doc._source.style
		console.log doc._source.name
		console.log doc._source.ingredients
).exec()