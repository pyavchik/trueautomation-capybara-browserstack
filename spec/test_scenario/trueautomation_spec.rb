require 'spec_helper'

feature 'TrueAutomation.IO capybara example' do
  scenario 'Test example' do
    visit 'https://trueautomation.io/'

    find(:css, ta('trueautomationio:home:loginBtn', 'a.login-btn')).click

    find(:css, ta('trueautomationio:signin:signupBtn', 'div.sign-up-container > a')).click

    fill_in ta('trueautomationio:signup:email', 'email'), with: 'your@mail.com'
    sleep 3
  end
end
