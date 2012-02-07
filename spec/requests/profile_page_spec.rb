require "spec_helper"
require "support/integration_spec_helper"

feature "Profile page" do
  subject { page }

  before :each do
    login_with_omniauth
  end

  after :each do
    visit logout_path
  end

  scenario "Switching tabs on the page", js: true do
    visit profile_path

    click_link 'Linked Accounts'
    should have_selector 'ul.nav.nav-tabs li.active a', text: 'Linked Accounts'
    should have_selector 'div.tab-content div.tab-pane.active#accounts'
    evaluate_script('window.location.hash').should eq('#/accounts')

    click_link 'General Information'
    should have_selector 'ul.nav.nav-tabs li.active a', text: 'General Information'
    should have_selector 'div.tab-content div.tab-pane.active#info'
    evaluate_script('window.location.hash').should eq('#/info')
  end

  scenario "Coming to the page with a matched hash-fragment url", js: true do
    visit profile_path + "#/accounts"

    should have_selector 'ul.nav.nav-tabs li.active a', text: 'Linked Accounts'
    should have_selector 'div.tab-content div.tab-pane.active#accounts'
  end

  scenario "Coming to the page with an unmatched hash-fragment", js: true do
    visit profile_path + "#/zomg"

    should have_selector 'ul.nav.nav-tabs li.active a', text: 'General Information'
    should have_selector 'div.tab-content div.tab-pane.active#info'
    evaluate_script('window.location.hash').should eq('#/info')
  end

  scenario "Coming to the page without a hash-fragment", js: true do
    visit profile_path

    should have_selector 'ul.nav.nav-tabs li.active a', text: 'General Information'
    should have_selector 'div.tab-content div.tab-pane.active#info'
    evaluate_script('window.location.hash').should eq('#/info')
  end

  pending "Linking a new login #{__FILE__}"
  pending "Attempting to link an existing login to the account that owns it #{__FILE__}"
  pending "Attempting to link an existing login to an account that doesn't own it #{__FILE__}"
  pending "Unlinking a login #{__FILE__}"
  pending "Attempting to unlink a login when the user only has one #{__FILE__}"
  pending "Attempting to unlink a login that doesn't belong to the user #{__FILE__}"

  pending "Attempting to delete a user account without being logged in #{__FILE__}"
  pending "Attempting to delete another user's account #{__FILE__}"
  pending "Deleting the current user's account #{__FILE__}"
end