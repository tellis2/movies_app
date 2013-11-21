class Movie < ActiveRecord::Base
	def self.search_for( query )
		Movie.where("title LIKE :query OR description Like :query",
			:query => "%#{query}%")
	end
end
