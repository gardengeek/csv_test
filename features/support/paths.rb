module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /the new person page/i
      new_person_path
    when /the account page/i
      '/'
    when /my account page/i
      user_path(@current_user)
    when /the new account page/i
      new_user_registration_path
    when /the session page/i
      new_user_session_path
    when /the sign in page/i
      sign_in_path
    when /the user sign in page/i
      new_user_session_path
    when /the passwords page/i
      user_password_path
    when /the sign up page/i
      new_user_registration_path
    when /the root sign up page/i
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /the new password page/i
      new_user_password_path
    when /my password reset page/i
      new_user_password_path(User.last.confirmation_token)
    when /my edit password reset page/i
      edit_user_password_path(User.last.confirmation_token)
    when /an invalid edit password reset page/i
      edit_account_password_reset_path("blah")
    when /my account confirmation page/i
      user_confirmation_path(User.last.confirmation_token)
    when /the user confirmation page/i
      user_confirmation_path(User.last.confirmation_token)
    when /the account confirmations page/i
      user_confirmation_path
    when /an invalid account confirmation page/i
      user_confirmation_path("blah")
    when /the new account confirmation page/i
      new_user_confirmation_path
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
