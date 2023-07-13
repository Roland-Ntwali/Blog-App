require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  describe '#update_likes_counter' do
    let(:post) { user.posts.create(title: 'Coding in progress', text: 'One line at a time') }
    let!(:like) { post.likes.create(author: user) }

    it 'increments the likes_counter on the associated post after create' do
      post.update(likes_counter: 0) # Reset the likes_counter to 0 for accurate testing

      expect do
        post.likes.create(author: user)
        post.reload
      end.to change { post.likes_counter }.by(1)
    end
  end

  it 'belongs to an author' do
    post = user.posts.create(title: 'Coding in progress', text: 'One line at a time')
    subject = post.likes.build(author: nil)
    expect(subject).to_not be_valid
  end

  it 'should be linked to a post' do
    user.posts.create(title: 'Coding in progress', text: 'One line at a time')
    subject = Like.new(author: user, post: nil)
    expect(subject).to_not be_valid
  end
end
