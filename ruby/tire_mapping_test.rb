require 'bundler/setup'
require 'tire'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/beer')

class TireMappingTest < Test::Unit::TestCase

	def setup
		Tire.index 'beer_recipes' do
		  create mappings:  {
		  	beer: {
		  		properties: { 
		  			ingredients:  { type: 'string', analyzer: 'snowball' } 
		  		} 
		  	}
		  }
	  end
	end

	def testIndexMappingAndSearch
	  Tire.index 'beer_recipes' do
			store type: 'beer',
        name: "Todd Enders' Witbier",
        style: "wit, Belgian ale, wheat beer",
        ingredients: "4.0 lbs Belgian pils malt, 4.0 lbs raw soft red winter wheat, 0.5 lbs rolled oats, 0.75 oz coriander, freshly ground Zest from two table oranges and two lemons, 1.0 oz 3.1% AA Saaz, 3/4 corn sugar for priming, Hoegaarden strain yeast"
      refresh
    end

    search_res = Tire.search('beer_recipes') do
    	query do
    		term :ingredients, 'lemon'
  		end
  	end

  	assert_equal 1, search_res.results.size
  	assert_equal "Todd Enders' Witbier", search_res.results[0].name

	end

	def teardown
		Tire.index 'beer_recipes' do
			delete
		end
	end
end