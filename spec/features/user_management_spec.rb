def sign_up 
  user = User.create(email: 'test@test.com',
  password: 'secret1234',
  username: 'tester',
  first_name: 'testerman',
  last_name: 'testerwoman')
  p user.saved?
end

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    # expect { sign_up }.to change(User, :count).by(1)
    sign_up
    
    visit("/sessions/new")
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'secret1234'
    click_button 'Sign in'
    expect(page).to have_content('test@test.com')
    # expect(User.first.email).to eq('test@test.com')
  end
end


feature 'User sign in' do

  let!(:user) do
    User.create(email: 'test@test.com',
                password: 'secret1234',
                username: 'tester',
                first_name: 'testerman',
                last_name: 'testerwoman')
  end

  scenario 'with correct credentials' do
    sign_in(email: user.email,   password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

end
