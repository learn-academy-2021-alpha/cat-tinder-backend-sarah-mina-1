require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /cats" do
    it 'gets a list of Cats' do
      # arrange - there needs to be some data in the db for the response
      Cat.create(name: 'Mr. Meow', age: 13, enjoys: 'playing with spaghetti')

      # act - simulating the HTTP GET request
      get '/cats'

      # assert
      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat_response.length).to eq 1
      first_cat = cat_response.first
      expect(first_cat['name']).to eq 'Mr. Meow'
      expect(first_cat['age']).to eq 13
      expect(first_cat['enjoys']).to eq 'playing with spaghetti'
    end
  end

  describe "POST /cats" do
    it 'creates a new cat' do
      # arrange - build request with params
      cat_params = {
        cat: {
          name: 'Garfield',
          age: 32,
          enjoys: 'silently judging you'
        }
      }

      # act - make POST request
      post '/cats', params: cat_params

      # assert
      # cat = Cat.first
      # expect(cat.name).to eq 'Garfield'
      # expect(cat.age).to eq 32
      # expect(cat.enjoys).to eq 'silently judging you'

      cat_response = JSON.parse(response.body)
      expect(cat_response['name']).to eq 'Garfield'
      expect(cat_response['age']).to eq 32
      expect(cat_response['enjoys']).to eq 'silently judging you'
    end
  end
end
