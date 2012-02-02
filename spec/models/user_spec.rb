require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new(name: "Example User", uid: 1, provider: "facebook")
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

  describe "provider" do
   it { should respond_to(:provider) }
   before { @user.save }
   its(:provider) { should_not be_blank }
  end

  describe "when provider is not present" do
    before { @user.provider = " " }
    it { should_not be_valid }
  end

  describe "uid" do
    it { should respond_to(:uid) }
    before { @user.save }
    its(:uid) { should_not be_blank }
  end

  describe "when uid is not present" do
    before { @user.uid = " " }
    it { should_not be_valid }
  end

   describe "when uid is already taken" do
    before do
      user_with_same_uid = @user.dup
      user_with_same_uid.save
    end

    it { should_not be_valid }
  end

  end
end
