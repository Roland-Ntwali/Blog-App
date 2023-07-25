require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET #index' do
    it 'successfull request' do
      get '/'
      expect(response).to be_successful
    end

    it 'should render the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET users from /users/:id to show' do
    user = User.create!(name: 'Tom', photo: 'https://picsum.photos/200/300', bio: 'I am John', post_counter: 4)

    it 'successful request' do
      get users_path
      expect(response).to be_successful
    end

    it 'should render the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end
  end
end
