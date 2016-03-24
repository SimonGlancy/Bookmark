def sign_up
  visit '/new_user'
  fill_in :username, with: "Chris"
  fill_in :email, with: "chris@gmail.com"
  fill_in :password, with: "notmypassword"
  fill_in :password_confirmation, with: "notmypassword"
  click_button "Submit"
end

def incorrect_sign_up
  visit '/new_user'
  fill_in :username, with: "Chris"
  fill_in :email, with: "chris@gmail.com"
  fill_in :password, with: "notmypassword"
  fill_in :password_confirmation, with: "asdsf"
  click_button "Submit"
end

def incorrect_email_sign_up
  visit '/new_user'
  fill_in :username, with: "Chris"
  fill_in :email, with: ""
  fill_in :password, with: "notmypassword"
  fill_in :password_confirmation, with: "notmypassword"
  click_button "Submit"
end
