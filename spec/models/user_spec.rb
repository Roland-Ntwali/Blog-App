require 'rails_helper'

describe User, type: :model do
  subject { User.new(name: 'Ama Ata Aidoo', photo: 'https://www.w4.org/wp-content/uploads/drupal-images/amaataaidoo.png', bio: 'Ama Ata Aidoo is a Ghanaian author, poet, playwright and academic. With a career spanning more than five decades') }
  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe '#three_recent_posts' do
    let!(:post1) { Post.create(author: subject, title: 'Post 1', text: 'This is my first post') }
    let!(:post2) do
      Post.create(author: subject, title: 'Post 2', text: 'This is my second post', created_at: 2.day.ago)
    end
    let!(:post3) { Post.create(author: subject, title: 'Post 3', text: 'This is my third post', created_at: 3.day.ago) }
    let!(:post4) do
      Post.create(author: subject, title: 'Post 4', text: 'This is my fourth post', created_at: 4.day.ago)
    end

    it 'returns the three most recent posts' do
      recent_post = subject.recent_posts
      puts recent_post
      expect(recent_post).to eq([post1, post2, post3])
    end

    it 'does not include posts older than the three most recent' do
      recent_posts = subject.recent_posts
      expect(recent_posts).not_to include(post4)
    end
  end
end
