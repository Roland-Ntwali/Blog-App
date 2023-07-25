require 'rails_helper'
RSpec.describe User, type: :system do
  subject { User.new(name: 'Tom', post_counter: 3, photo: 'https://pic.com', bio: 'Project manager') }
  before { subject.save }
  describe 'index page' do
    it 'I can see the username of all other users.' do
      visit root_path(subject)
      expect(page).to have_content(subject.name)
    end
    it 'I can see the profile picture for each user' do
      visit root_path(subject)
      expect(page).to have_css('img')
    end
    it 'I can see the number of posts each user has written.' do
      visit root_path(subject)
      expect(page).to have_content(subject.post_counter)
    end
    it "When I click on a user, I am redirected to that user's show page." do
      user2 = User.create(name: 'Lilly', post_counter: 2, photo: 'https://randomuser.me/api/portraits/women/70.jpg',
                          bio: 'Teacher from Poland.')
      visit root_path(user2)
      click_on 'Lilly'
      expect(page).to have_content('Lilly')
    end
  end
end
