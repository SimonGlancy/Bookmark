feature 'new user' do
  scenario 'allows a new user to sign up' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Chris"
    expect(User.first.email).to eq "chris@gmail.com"
  end
end

feature 'new user incorrect password verification' do
  scenario 'does not create a new user' do
    expect { incorrect_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new_user'
    expect(page).to have_content 'Passwords do not match'
  end
end

feature 'new user incorrect email verification' do
  scenario 'cannot sign-up with blank email' do
    expect { incorrect_email_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new_user'
    expect(page).to have_content 'Incorrect email'
  end
end
