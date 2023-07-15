require 'rails_helper'

describe Like, type: :model do
  let(:user) { User.create(name: 'Jake', photo: 'user.png', bio: 'Jake is a 21-year-old footballer from Ghana') }
  let(:post) { Post.create(author: user, title: 'My first post', text: 'Ghana is in West Africa') }

  describe 'Associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Post')
    end
  end

  describe 'Callbacks' do
    describe 'after_save' do
      it 'updates the likes_counter of the associated post' do
        expect(post.likes_counter).to eq(0)

        Like.create(author: user, post:)

        expect(post.reload.likes_counter).to eq(1)
      end
    end
  end
end
