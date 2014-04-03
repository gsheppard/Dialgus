module AuthenticationHelper
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within(:css, '.form-actions') do
      click_on 'Sign In'
    end
  end
end
