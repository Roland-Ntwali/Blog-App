require 'rails_helper'

describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) { get '/users/1/posts' }

    it 'successfull request' do
      expect(response.status).to eq(200)
    end

    it 'should render the index template' do
      expect(response).to render_template(:index)
    end

    it 'should render the index placeholder' do
      expect(response.body).to include('List of all posts by user')
    end
  end

  describe 'GET #show' do
    before(:example) { get '/users/1/posts/1' }

    it 'successful request' do
      expect(response.status).to eq(200)
    end

    it 'should render the show template' do
      expect(response).to render_template(:show)
    end

    it 'should render the show placehoder' do
      expect(response.body).to include('Post by a specific user')
    end
  end
end
