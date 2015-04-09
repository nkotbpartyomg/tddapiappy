class CharactersController < ApplicationController

	def index
		render json: Character.all
	end

	def show
		@character = Character.find(params[:id])
		render json: @character
	end

	def create
		@character = Character.create(character_params)
		if @character.save
			render json: @character, status: 201
		end
	end

  private

    def character_params
      params.require(:character).permit(:name, :style)
    end

end