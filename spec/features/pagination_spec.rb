require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Pagination on posts index page', type: :feature do
  scenario 'User views the list of posts with pagination' do
    FactoryBot.create_list(:post, 15, topic: FactoryBot.create(:topic))

    visit posts_path
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 10')
    expect(page).to_not have_content('Post 11')
    expect(page).to have_selector('.pagy-nav') # Pagination controls should be visible
    click_link('Next')
    expect(page).to_not have_content('Post 1')
    expect(page).to_not have_content('Post 10')
    expect(page).to have_content('Post 11')
    expect(page).to have_selector('.pagy-nav') # Pagination controls should still be visible

    click_link('Previous')

    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 10')
    expect(page).to_not have_content('Post 11')
    expect(page).to have_selector('.pagy-nav') # Pagination controls should still be visible
  end
end
