require 'spec_helper'

feature 'User management' do
    background do
	  @admin = FactoryGirl.create(:admin)
	  @role = Role.create!(name: "admin")
	  @attr = {
      :email => "newuser@example.com",
      :password => "changeme",
      :password_confirmation => "changeme",
      :id => User.count+1
    }
	
	  visit root_path
	  expect{
	    click_link 'Sign up'

	    fill_in 'Email', with: @attr[:email]
	    fill_in 'Password', with: @attr[:password]
	        
	    fill_in 'Password confirmation', with: @attr[:password_confirmation]
	    click_button 'Sign up'
	  }.to change(User, :count).by(1)
	  expect(current_path).to eq root_path
	  expect(page).to have_content 'Welcome! You have signed up successfully'
	end

	
	scenario "updates a new user to Admin", js: true do
	click_link 'Logout'
	sign_in @admin
	visit root_path
	click_link 'Users'
	expect(page).to have_content "#{@attr[:email]}"

	#locate("//*[@id=role-options-#{@attr[:id]}}]").find("//a").click
	#find_link("@id=role-options-#{@attr[:id]}").click
	#find('a', :match => "role-options-#{@attr[:id]}").click
	#find('//a')
	#find(:xpath, "//a[contains(@role-options-#{@attr[:id]})]").click
	#find(:xpath, ".//table/tr/td[]")
	find(:css, "a[data-reveal-id=" + "role-options-#{@attr[:id]}]").click

	expect(page).to have_content @role.name

  end
end