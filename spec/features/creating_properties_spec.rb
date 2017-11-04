feature 'Creating property listing' do
  before do
    User.create(email: 'test@test.com', password: '123', username: 'tester', first_name: 'testerman', last_name: 'testerwoman')
    visit '/sessions/new'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: '123'
    click_button 'Sign in'
    visit '/properties/new'
    fill_in :description, with: 'Big house in leafy suburb'
    fill_in :price, with: 50
    click_button 'Create Listing'
  end
  scenario 'as a landlord i can create a listing' do
    expect(current_path).to eq '/properties'
    within 'ul#properties' do
      expect(page).to have_content('Big house in leafy suburb')
    end
  end
end
