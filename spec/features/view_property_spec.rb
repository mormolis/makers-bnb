require './app/models/property.rb'

feature 'Viewing a list of properties' do
  before do
    User.create(email: 'test@test.com',
    password: 'secret1234',
    username: 'tester',
    first_name: 'testerman',
    last_name: 'testerwoman')
    Property.create(description: 'Big house in leafy suburb', price: 50, user_id: User.first.id)
    Property.create(description: 'Small flat', price: 100, user_id: User.first.id)
  end
  scenario 'See list of properties as I scroll down page' do
    visit '/properties'
    expect(page.status_code).to eq 200
    within 'ul#properties' do
      expect(page).to have_content('Big house in leafy suburb')
    end
  end

  scenario 'Properties have their own page' do
    visit '/properties'
    within 'ul#properties' do
      click_link 'Big house in leafy suburb 50 test@test.com'
    end
    expect(current_path).to eq '/properties/book:6'
    expect(page).to have_content 'Big house in leafy suburb'
    expect(page).not_to have_content 'Small flat'
  end
end
