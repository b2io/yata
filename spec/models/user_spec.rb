require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  describe 'User should respond to' do
    subject { @user }

    describe "name" do
      it { should respond_to(:name) }

      before { @user.save }
      its(:name) { should_not be_blank }
    end

    describe "when name is not present" do
      before { @user.name = " " }
      it { should_not be_valid }
    end

    describe "email" do
      it { should respond_to(:email) }

      before { @user.save }
      its(:email) { should_not be_blank }
    end

    describe "when email is not present" do
      before { @user.name = " " }
      it { should_not be_valid }
    end
  end

end
