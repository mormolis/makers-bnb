require './app/models/property.rb'

feature 'Viewing a list of properties' do
  scenario 'See list of properties as I scroll down page' do
    Property.create(description: 'Big house in leafy suburb', price: 50)
    p Property.all

    visit '/properties'

    p Property.all
    expect(page.status_code).to eq 200
    within 'ul#properties' do
      expect(page).to have_content('Big house in leafy suburb')
    end
  end
end
