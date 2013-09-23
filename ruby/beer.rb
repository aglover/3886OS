class Beer

	attr_reader :name, :style, :ingredients

	class << self
		def search_ingredients_for(ingredient)
			search_res = Tire.search('beer_recipes') do
	    	query do
	    		term :ingredients, ingredient
	  		end
	  	end
	  	search_res.results
		end
	end

	def initialize(attributes={})
  	@attributes = attributes
    @attributes.each_pair { |name,value| instance_variable_set :"@#{name}", value }
  end

  def type
	  'beer'
  end

  def to_indexed_json
    @attributes.to_json
  end

end