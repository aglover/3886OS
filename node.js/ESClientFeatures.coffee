require 'should'
require 'mocha'
ElasticSearchClient = require 'elasticsearchclient'

client = new ElasticSearchClient { host: 'localhost', port: 9200 }
indexName = 'beer_recipes'
objName = 'beer'

describe 'Working with Node ElasticSearchClient should be easy!', ->

	describe 'Create and update an index', ->
		before (done) ->
			client.createIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()
			
		it 'should support a mapping put which changes the analyzer', (done) ->
			snowball = { "mappings" : { "beer" : { "properties" : { "ingredients" : { "type" : "string", "analyzer" : "snowball" } } } }}
			client.putMapping(indexName, objName, snowball).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()

		after (done) ->
			client.deleteIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()

	describe 'support get-style search results', ->
		before (done) ->
			client.createIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()
			
		it 'should find one result', (done) ->
			beer = { "name": "Todd Enders' Witbier", "style": "wit, Belgian ale, wheat beer", "ingredients": "4.0 lbs Belgian pils malt, 4.0 lbs raw soft red winter wheat, 0.5 lbs rolled oats, 0.75 oz coriander, freshly ground Zest from two table oranges and two lemons, 1.0 oz 3.1% AA Saaz, 3/4 corn sugar for priming, Hoegaarden strain yeast"}
			client.index(indexName, objName, beer).on 'data', (data) ->
				data = JSON.parse data
				data.ok.should.equal true
				doc_id = data._id

				client.get(indexName, objName, doc_id).on 'data', (getData) ->
					doc = JSON.parse getData
					doc._source.name.should.equal "Todd Enders' Witbier"
					done()
				.exec()
			.exec()

		after (done) ->
			client.deleteIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()

	describe 'support traditional search behavior', ->
		before (done) ->
			client.createIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				beer = { "name": "Todd Enders' Witbier", "style": "wit, Belgian ale, wheat beer", "ingredients": "4.0 lbs Belgian pils malt, 4.0 lbs raw soft red winter wheat, 0.5 lbs rolled oats, 0.75 oz coriander, freshly ground Zest from two table oranges and two lemons, 1.0 oz 3.1% AA Saaz, 3/4 corn sugar for priming, Hoegaarden strain yeast"}
				client.index(indexName, objName, beer).on('data', (data) ->
					beer_2 = { name: "Wit", style: "wit, Belgian ale, wheat beer", ingredients: "4 lbs DeWulf-Cosyns 'Pils' malt, 3 lbs brewers' flaked wheat (inauthentic; will try raw wheat nest time), 6 oz rolled oats, 1 oz Saaz hops (3.3% AA), 0.75 oz bitter (Curacao) orange peel quarters (dried), 1 oz sweet orange peel (dried), 0.75 oz coriander (cracked), 0.75 oz anise seed, one small pinch cumin, 0.75 cup corn sugar (priming), 10 ml 88% food-grade lactic acid (at bottling), BrewTek 'Belgian Wheat' yeast"}
					client.index(indexName, objName, beer_2).on('data', (data) ->
						result = JSON.parse data
						done()
					).exec()
				).exec()
			.exec()

		it 'should easily find a result via a search', (done) ->
			iquery = { "query" : { "term" : { "ingredients" : "lemons" } } }
			setTimeout ->
				client.search(indexName, objName, iquery).on 'data', (idata) ->
					result = JSON.parse idata
					result.hits.total.should.equal 1
					done()
				.exec()
			, 3000 #timeout introduced to let ES index a document before a search
			
		after (done) ->
			client.deleteIndex(indexName).on 'data', (data) ->
				data = JSON.parse data
				data.should.be.ok
				done()
			.exec()

