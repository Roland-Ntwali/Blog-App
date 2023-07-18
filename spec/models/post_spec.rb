require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'Jake', photo: 'user.png', bio: 'Jake is a 21 year old footballer from Ghana') }
  let(:post) { Post.create(author: user, title: 'My first post', text: 'Ghana is in West Africa') }
  before { subject.save }

  describe 'Validations' do
    it 'title should be present' do
      post1 = Post.new(author: user, text: 'Ghana is in West Africa')
      expect(post1).not_to be_valid
      expect(post1.errors[:title]).to include("can't be blank")
    end

    it 'validates maximum length of title' do
      post2 = Post.new(author: user, title: 'A' * 251, text: 'Ghana is in West Africa')
      expect(post2).not_to be_valid
      expect(post2.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates numericality of comments_counter' do
      post3 = Post.new(author: user, title: 'My first post', text: 'Ghana is in West Africa',
                       comments_counter: 'not_an_integer')
      expect(post3).not_to be_valid
      expect(post3.errors[:comments_counter]).to include('is not a number')
    end

    it 'validates numericality of likes_counter' do
      post4 = Post.new(author: user, title: 'My first post', text: 'Ghana is in West Africa',
                       likes_counter: 'not_an_integer')
      expect(post4).not_to be_valid
      expect(post4.errors[:likes_counter]).to include('is not a number')
    end
  end

  describe 'Associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.class_name).to eq('Comment')
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.class_name).to eq('Like')
    end
  end

  describe '#five_recent_comments' do
    it 'returns the five most recent comments in descending order' do
      comment1 = Comment.create(author: user, post:, text: 'Comment 1', created_at: 2.days.ago)
      comment2 = Comment.create(author: user, post:, text: 'Comment 2', created_at: 1.day.ago)
      comment3 = Comment.create(author: user, post:, text: 'Comment 3', created_at: 3.days.ago)
      comment4 = Comment.create(author: user, post:, text: 'Comment 4', created_at: 4.days.ago)
      comment5 = Comment.create(author: user, post:, text: 'Comment 5', created_at: 5.days.ago)
      Comment.create(author: user, post:, text: 'Comment 6', created_at: 6.days.ago)

      five_recent_comments = post.recent_comments

      expect(five_recent_comments).to eq([comment2, comment1, comment3, comment4, comment5])
    end

    it 'limits the result to a maximum of five comments' do
      6.times do |index|
        Comment.create(author: user, post:, text: "Comment #{index + 1}")
      end

      five_recent_comments = post.recent_comments

      expect(five_recent_comments.count).to eq(5)
    end
  end
end
