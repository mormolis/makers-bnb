feature 'Creating property listing' do
  scenario 'as a landlord i can create a listing' do
    visit '/properties/new'
    fill_in :description, with: 'Big house in leafy suburb'
    fill_in :price, with: 50
    click_button 'Create Listing'

    expect(current_path).to eq '/properties'

    within 'ul#properties' do
      expect(page).to have_content('Big house in leafy suburb')
    end
  end
end
