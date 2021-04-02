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

    it 'cannot create a new cat without a name' do
      cat_params = {
        cat: {
          age: 8,
          enjoys: 'Sleeping on your face'
        }
      }

      post '/cats', params: cat_params

      error_response = JSON.parse(response.body)
      expect(error_response['name']).to include "can't be blank"
      expect(response).to have_http_status(422)
    end

    it 'cannot create a new cat without a age' do
      cat_params = {
        cat: {
          name: 'Tom',
          enjoys: 'Sleeping on your face'
        }
      }

      post '/cats', params: cat_params

      error_response = JSON.parse(response.body)
      expect(error_response['age']).to include "can't be blank"
      expect(response).to have_http_status(422)
    end

    it 'cannot create a new cat without an enjoys description' do
      cat_params = {
        cat: {
          name: 'Tom',
          age: 10
        }
      }

      post '/cats', params: cat_params

      error_response = JSON.parse(response.body)
      expect(error_response['enjoys']).to include "can't be blank"
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT /cats' do
    it 'edits a cat' do
      # arrange - there needs to be a cat in the DB to update
      cat = Cat.create(name: 'Mr. Meow', age: 13, enjoys: 'playing with spaghetti')

      # arrange - the request params are trying to edit that cat
      update_cat_params = {
        cat: {
          name: 'Felix',
          age: 2,
          enjoys: 'Walks in the park.'
        }
      }

      # act
      put "/cats/#{cat.id}", params: update_cat_params
      
      # assert - on response
      updated_cat_response = JSON.parse(response.body)
      expect(updated_cat_response['name']).to eq 'Felix'
      expect(updated_cat_response['age']).to eq 2
      expect(updated_cat_response['enjoys']).to eq 'Walks in the park.'
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /cats' do
    it 'deletes a cat' do
      # arrange - there needs to be a cat in the DB to delete
      cat = Cat.create(name: 'Mr. Meow', age: 13, enjoys: 'playing with spaghetti')
      
      # act
      delete "/cats/#{cat.id}"

      # assert - db no longer has that record
      no_cat = Cat.where(id: cat.id)
      expect(no_cat).to be_empty

      # assert - on delete response
      delete_response = JSON.parse(response.body)
      expect(delete_response['name']).to eq 'Mr. Meow'
      expect(delete_response['age']).to eq 13
      expect(delete_response['enjoys']).to eq 'playing with spaghetti'
      expect(response).to have_http_status(200)
    end
  end
end
