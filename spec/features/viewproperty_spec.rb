require './app/models/property.rb'

feature 'Viewing a list of properties' do
  before do
    User.create(email: 'test@test.com',
    password: 'secret1234',
    username: 'tester',
    first_name: 'testerman',
    last_name: 'testerwoman')
    Property.create(description: 'Big house in leafy suburb', price: 50, user_id: User.first.id)
  end

  scenario 'See list of properties as I scroll down page' do
    visit '/properties'
    expect(page.status_code).to eq 200
    within 'ul#properties' do
      expect(page).to have_content('Big house in leafy suburb')
    end
  end
end
