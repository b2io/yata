require "spec_helper"
require "support/integration_spec_helper"

feature "Profile page" do
  subject { page }

  before :each do
    login_with_omniauth
    visit profile_path
  end

  after :each do
    logout
  end

  scenario "Switching tabs on the page", js: true do
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
    visit profile_path + "#/does-not-exist"

    should have_selector 'ul.nav.nav-tabs li.active a', text: 'General Information'
    should have_selector 'div.tab-content div.tab-pane.active#info'
  end

  scenario "Coming to the page without a hash-fragment", js: true do
    should have_selector 'ul.nav.nav-tabs li.active a', text: 'General Information'
    should have_selector 'div.tab-content div.tab-pane.active#info'
  end

  scenario "Should list the linked logins properly", js: true do
    click_link 'Linked Accounts'
    within 'table#linked-login-list tbody' do
      should have_content 'Google 01234 user@example.com'
    end
  end

  scenario "Linking a new login", js: true do
    click_link 'Linked Accounts'
    click_link 'Link a Facebook login'
    within 'table#linked-login-list tbody' do
      should have_content 'Google 01234 user@example.com'
      should have_content 'Facebook 56789 user@example.com'
    end
  end

  scenario "Attempting to link an existing login to the account that doesn't owns it", js: true do
    logout
    login_with_omniauth :facebook
    logout
    login_with_omniauth
    visit profile_path

    click_link 'Linked Accounts'
    click_link 'Link a Facebook login'

    should have_selector 'div.alert', text: "That login is linked to another YATA account."
  end

  scenario "Attempting to link an existing login to the account that owns it", js: true do
    click_link 'Linked Accounts'
    click_link 'Link a Facebook login'
    click_link 'Link a Facebook login'

    should have_selector 'div.alert', text: "That login is already linked to this YATA account."
  end

  pending "Unlinking a login #{__FILE__}"
  pending "Attempting to unlink a login when the user only has one #{__FILE__}"
  pending "Attempting to unlink a login that doesn't belong to the user #{__FILE__}"

  pending "Attempting to delete a user account without being logged in #{__FILE__}"
  pending "Attempting to delete another user's account #{__FILE__}"
  pending "Deleting the current user's account #{__FILE__}"
end