class MoviesController < ApplicationController
	def index
		if params[:q].present?
			@movies = Movie.search_for(params[:q]).order("created_at desc")
		else
			@movies = Movie.all.order("created_at desc")
		end
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new( safe_movie_params )
		logger.info( "My movie object is: #{@movie.inspect}") 
			@movie.save
		redirect_to root_path
	end

	def edit
		@movie = Movie.find( params[:id])
	end

	def update
		@movie = Movie.find( params[:id])
		@movie.update( safe_movie_params)
		redirect_to movie_path(@movie)
	end

	def destroy
	@movie = Movie.find(params[:id])
	@movie.destroy

	redirect_to root_path
	end

private

	def safe_movie_params
		return params.require(:movie).permit(:title, :description, :year_released)
	end
end
