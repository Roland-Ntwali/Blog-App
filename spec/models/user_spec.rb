require 'rails_helper'
# require_relative '../app/models/user'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(name: 'Taflon', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

    it 'Name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'photo should be present' do
      subject.photo = nil
      expect(subject).to_not be_valid
    end

    it 'bio should be present' do
      subject.bio = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be an interger' do
      subject.posts_counter = ''
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'Taflon', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

    let(:first_post) { user.posts.create(title: 'Hello', text: 'This is my first post') }
    let(:second_post) { user.posts.create(title: 'I am changing the world!', text: 'This is my second post') }
    let(:third_post) { user.posts.create(title: 'Coding in progress', text: 'One line at a time') }
    let(:fourth_post) { user.posts.create(title: 'Show love', text: 'You cant love too much') }

    it 'returns the most recent three posts' do
      recent_posts = user.recent_posts

      expect(recent_posts).to contain_exactly(fourth_post, third_post, second_post)
      expect(recent_posts.length).to eq(3)
    end
  end
end
