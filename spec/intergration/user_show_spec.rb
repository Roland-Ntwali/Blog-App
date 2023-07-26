require 'rails_helper'
RSpec.describe User, type: :feature do
  subject { User.new(name: 'John', post_counter: 3, photo: 'https://pic.com', bio: 'Project Owner') }
  before { subject.save }
  describe 'User show page' do
    it "I can see the user's profile picture." do
      visit user_path(subject.id)
      expect(page).to have_css('img')
    end
    it "I can see the user's username." do
      visit user_path(subject.id)
      expect(page).to have_content(subject.name)
    end
    it 'I can see the number of posts the user has written.' do
      visit user_path(subject.id)
      expect(page).to have_content(subject.post_counter)
    end
    it "I can see the user's bio." do
      visit user_path(subject.id)
      expect(page).to have_content(subject.bio)
    end
    it "I can see the user's first 3 posts." do
      Post.create([{ author: subject, title: 'First Post', text: 'My first post' },
                   { author: subject, title: 'Second Post', text: 'My Second post' },
                   { author: subject, title: 'Third Post', text: 'My Third post' }])
      visit user_path(subject.id)
      expect(page).to have_content('First Post')
      expect(page).to have_content('Second Post')
      expect(page).to have_content('Third Post')
    end
    it "I can see a button that lets me view all of a user's posts." do
      visit user_path(subject.id)
      expect(page).to have_button('See all Post')
    end
    it "When I click a user's post, it redirects me to that post's show page." do
      post = Post.create(author: subject, title: 'First Post', text: 'First post')
      visit user_path(subject.id)
      click_on 'First Post'
      visit user_post_path(subject.id, post.id)
      expect(page).to have_content('First Post')
    end
    it "When I click to see all posts, it redirects me to the user's post's index page." do
      Post.create(author: subject, title: 'First Post', text: 'First post')
      visit user_path(subject.id)
      click_link 'See all Post'
      expect(page).to have_current_path(user_posts_path(subject))
    end
  end
end
