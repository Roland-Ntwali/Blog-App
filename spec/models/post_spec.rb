require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  subject { user.posts.create(title: 'Coding in progress', text: 'One line at a time') }

  describe 'validations' do
    it 'should have a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should have text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'title should not be greater than 250' do
      subject.title = 'Hello world' * 25
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = ''
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      subject.likes_counter = ''
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_comments' do
    let(:commenter2) { User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }

    it 'returns the most recent 5 comments' do
      subject.comments.create(author: commenter2, text: 'Hi Tom!')
      comment2 = subject.comments.create(author: user, text: 'Hi Lilly!')
      comment3 = subject.comments.create(author: commenter2, text: 'Hope you all done with your project?')
      comment4 = subject.comments.create(author: user, text: 'I asked after you from Ebun yesterday')
      comment5 = subject.comments.create(author: commenter2, text: 'Oh, really, thanks.')
      comment6 = subject.comments.create(author: user, text: 'I am almost done with the project')
      recent_comments = subject.recent_comments

      expect(recent_comments).to contain_exactly(comment6, comment5, comment4, comment3, comment2)
      expect(recent_comments.length).to eq(5)
    end
  end

  describe '#update_posts_counter' do
    it 'updates the posts_counter on the associated author after save' do
      user.update(posts_counter: 0)

      expect do
        user.posts.create(title: 'New Post', text: 'Content')
        user.reload
      end.to change { user.posts_counter }.by(1)
    end
  end
end
