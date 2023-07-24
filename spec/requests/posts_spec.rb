require 'rails_helper'

describe 'Posts', type: :request do
  before(:each) do
    user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 1)
    get "/users/#{user.id}/posts"
  end

  it 'successfull request' do
    expect(response).to be_successful
  end

  it 'should render the index template' do
    expect(response).to render_template(:index)
  end

  it 'should render the index placeholder' do
    expect(response.body).to include('<ul class="photo"> ')
  end

  describe 'GET users from /users/:id to show' do
    user = User.create!(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)
    post = Post.create!(author: user, title: 'title', text: ' Post text 1', comments_counter: 0, likes_counter: 0)

    it 'successful request' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'should render the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'should render the show placeholder' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('<div class="post_comment">')
    end
  end
end
