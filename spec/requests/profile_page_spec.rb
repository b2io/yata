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
    should have_selector 'div.alert-success', text: 'Successfully linked that login to your YATA account.'
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

    should have_selector 'div.alert-warn', text: "That login is already linked to this YATA account."
  end

  scenario "Unlink option hidden when user has only one linked login", js: true do
    # Verify there are no unlink actions offered
    click_link 'Linked Accounts'
    evaluate_script("$('a[data-unlink]').length").should eq(0)

    # Link a second account; verify there are now two unlink actions offered.
    click_link 'Link a Facebook login'
    page.evaluate_script("$('a[data-unlink]').length").should eq(2)
  end

  scenario "Unlink icon triggers modal confirmation which can be canceled two ways", js: true do
    # Link a second account.
    click_link 'Linked Accounts'
    click_link 'Link a Facebook login'

    # Try to unlink the first account, but cancel using the button in the footer; verify there are still two accounts.
    page.execute_script("$('a[data-unlink]')[0].click()")
    should have_css '#confirm-unlink', visible: true
    page.execute_script("$('#confirm-unlink .modal-footer a[title=\"Cancel\"]').click()")
    should have_css '#confirm-unlink', visible: false
    page.evaluate_script("$('a[data-unlink]').length").should eq(2)

    # Try to unlink the second account, but cancel using the button in the header; verify there are still two accounts.
    page.execute_script("$('a[data-unlink]')[1].click()")
    should have_css '#confirm-unlink', visible: true
    page.execute_script("$('#confirm-unlink .modal-header a[title=\"Cancel\"]').click()")
    should have_css '#confirm-unlink', visible: false
    page.evaluate_script("$('a[data-unlink]').length").should eq(2)
  end

  scenario "Unlinking a login", js: true do
    # Link a second account.
    click_link 'Linked Accounts'
    click_link 'Link a Facebook login'

    # Unlink the first account; verify that the account is gone.
    page.execute_script("$('a[data-unlink=\"1\"]').click()")
    should have_css '#confirm-unlink', visible: true
    page.execute_script("$('#confirm-unlink .modal-footer a[title=\"Unlink Provider\"]').click()")
    should have_css '#confirm-unlink', visible: false
    should have_no_content 'Google 01234 user@example.com'
    should have_selector 'div.alert-success', text: 'Successfully unlinked that login from your YATA account.'
  end

  scenario "Delete account button triggers modal confirmation which can be canceled two ways", js: true do
    # Try to delete the account, but cancel using the button in the footer.
    click_link 'Delete Account'
    should have_css '#confirm-delete-account', visible: true
    page.execute_script("$('#confirm-delete-account .modal-footer a[title=\"Cancel\"]').click()")
    should have_css '#confirm-delete-account', visible: false

    # Try to delete the account, but cancel using the button in the header.
    click_link 'Delete Account'
    should have_css '#confirm-delete-account', visible: true
    page.execute_script("$('#confirm-delete-account .modal-header a[title=\"Cancel\"]').click()")
    should have_css '#confirm-delete-account', visible: false
  end

  scenario "Deleting your account", js: true do
    click_link 'Delete Account'
    should have_css '#confirm-delete-account', visible: true
    page.execute_script("$('#confirm-delete-account .modal-footer a[title=\"Delete Account\"]').click()")
    should have_selector 'div.alert-success', text: 'Your account has been deleted.'
  end
end