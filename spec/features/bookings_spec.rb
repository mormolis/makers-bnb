feature 'Making a booking' do
  scenario 'As a landlord/visitor I can book a listed property' do
    pending()
    User.create(email: 'test@test.com',
    password: 'secret1234',
    username: 'tester',
    first_name: 'testerman',
    last_name: 'testerwoman')
    Property.create(description: 'Big house', price: 200, user_id: User.first.id)
    Property.create(description: 'Small flat', price: 200, user_id: User.first.id)
    visit '/properties/book:1'
    fill_in :check_in, with: "16/10/1986"
    fill_in :check_out, with: "16/10/1987"
    # fill_in :user_id, with: 1
    click_button 'Book'
    expect(current_path).to eq '/bookings'

    within 'ul#bookings' do
      expect(page).to have_content('Big house')
      expect(page).not_to have_content('Small flat')
    end
  end
end



