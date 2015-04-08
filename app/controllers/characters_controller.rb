class CharactersController < ApplicationController

	def index
		render json: Character.all
	end

	def show
		@character = Character.find(params[:id])
		render json: @character
	end

end