require 'rails_helper'

describe "Weetzie Bat Characters API"  do
	describe "GET /characters" do
		it "returns a list of all the characters" do
			FactoryGirl.create :character, name: "Valentine Jah Love"
      		FactoryGirl.create :character, name: "My Secret Agent Lover Man"
			FactoryGirl.create :character, name: "Witch Baby"

			get "/characters", {}, { "Accept" => "application/json" }
			expect(response.status).to eq 200

			body = JSON.parse(response.body)
			character_names = body.map { |c| c["name"] }

			expect(character_names).to match_array(["Valentine Jah Love", "My Secret Agent Lover Man", "Witch Baby"])
		end
	end

	describe "GET /characters/:id" do
		it "returns a requested character" do
			c = FactoryGirl.create :character, name: "Angel Juan"

			get "/characters/#{c.id}", {}, { "Accept" => "application/json" }
			expect(response.status).to eq 200

			body = JSON.parse(response.body)
			expect(body["name"]).to eq "Angel Juan"
		end
	end

	describe "POST /characters" do
		it "creates a character" do
			character_params = {
				character: {
					name: "Weetzie Bat",
					style: "bleach-blonde flat-top, dresses with fringe"
				}
			}.to_json	

			request_headers = {
				"Accept" => "application/json",
				"Content-Type" => "application/json"
			}

			post "/characters", character_params, request_headers
			
			expect(response.status).to eq 201 #created
			expect(Character.first.style).to eq "bleach-blonde flat-top, dresses with fringe"
		end
	end

end