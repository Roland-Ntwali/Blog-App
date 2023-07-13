require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  describe '#update_comments_counter' do
    let(:post) { user.posts.create(title: 'Coding in progress', text: 'One line at a time') }
    let(:comment) { post.comments.create(author: user, text: 'Hope you all done with your project?') }

    it 'updates the comments counter on the associated post after save' do
      expect { comment.save }.to change { post.reload.comments_counter }.by(1)
    end

    it 'updates the comments counter on the associated post after destroy' do
      comment.save
      expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
    end
  end

  it 'validates the presence of text' do
    post = user.posts.create(title: 'Coding in progress', text: 'One line at a time')
    subject = post.comments.create(author: user, text: 'Hope you all done with your project?')

    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'belongs to an author' do
    post = user.posts.create(title: 'Coding in progress', text: 'One line at a time')
    subject = post.comments.create(author: user, text: 'Hope you all done with your project?')

    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should be linked to a post' do
    post = user.posts.create(title: 'Coding in progress', text: 'One line at a time')
    subject = post.comments.create(author: user, text: 'Hope you all done with your project?')

    subject.post = nil
    expect(subject).to_not be_valid
  end
end
