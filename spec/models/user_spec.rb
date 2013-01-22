# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  # Validates that User model has name,email,password_digest attributes
  before do
    @user = User.new( name: "John Doe", email: "Johndoe@hotmail.com",
                                         password: "my_password", password_confirmation: "my_password" )
  end

  subject { @user }

  it {should respond_to( :name )}
  it {should respond_to(:email )}
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate)}
  it { should respond_to(:requestposts) }
  it { should respond_to(:request_feed) }
  it { should respond_to(:mate_feed) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to true" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  # Validates that name field isn't left out blank
  describe "when name field is left blank" do
    before { @user.name = "" }
    it {should_not be_valid }
  end

  # Validates that email field isn't left out blank
  describe "when email field is left blank" do
    before { @user.email = "" }
    it {should_not be_valid }
  end

  # Validates that name selected isn't longer than 50 characters
  describe "when name selected is longer than 50 characters" do
    before { @user.name = "a" * 51}
    it {should_not be_valid }
  end

  # Validates that no improper email address is selected
  describe "when email format is invalid" do
    it "should be invalid" do
      email_addresses = %w[user@address,com user_at_address.com user.name@address.mail@other_address.com user@add+ress.com]
      email_addresses.each do |invalid_email_address|
        @user.email = invalid_email_address
        @user.should_not be_valid
      end
    end
  end

  # Validates that a proper email address is selected
  describe "when email format is valid" do
    it "should be valid" do
      email_addresses = %w[user@address.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      email_addresses.each do |valid_email_address|
        @user.email = valid_email_address
        @user.should be_valid
      end
    end
  end

  # Validates uniqueness of selected email address
  describe "when selected email address is already taken" do
    before do
      user_with_same_email_address = @user.dup
      user_with_same_email_address.email = @user.email.upcase
      user_with_same_email_address.save
    end

    it {should_not be_valid}
  end

  # Validates password field isn't blank
  describe "when password field is left blank" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  # Validates password's minimum length
  describe "selected password length is too short" do
    before { @user.password = @user.password_confirmation = "a" * 7 }
    it { should_not be_valid }
  end

  # Validates password_confirmation isn't nil
  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  # Validates password and password_confirmation fields are identical
  describe "when password and password_confirmation fields don't match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "non-blank remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "requestpost associations" do

    before { @user.save }
    let!(:older_requestpost) do
      FactoryGirl.create(:requestpost, :user => @user, :created_at => 1.day.ago)
    end
    let!(:newer_requestpost) do
      FactoryGirl.create(:requestpost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have the right requestposts in the right order" do
      @user.requestposts.should == [newer_requestpost, older_requestpost]
    end

    it "should destroy associated requestposts" do
      requestposts = @user.requestposts.dup
      @user.destroy
      requestposts.should_not be_empty
      requestposts.each do |requestpost|
        Requestpost.find_by_id(requestpost.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:requestpost, user: FactoryGirl.create(:user))
      end

      its(:request_feed) { should include(newer_requestpost) }
      its(:request_feed) { should include(older_requestpost) }
    end
  end

  describe "matepost associations" do

    before { @user.save }
    let!(:older_matepost) do
      FactoryGirl.create(:matepost, :user => @user, :created_at => 1.day.ago)
    end
    let!(:newer_matepost) do
      FactoryGirl.create(:matepost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have the right mateposts in the right order" do
      @user.mateposts.should == [newer_matepost, older_matepost]
    end

    it "should destroy associated mateposts" do
      mateposts = @user.mateposts.dup
      @user.destroy
      mateposts.should_not be_empty
      mateposts.each do |matepost|
        Requestpost.find_by_id(matepost.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:matepost, user: FactoryGirl.create(:user))
      end

      its(:mate_feed) { should include(newer_matepost) }
      its(:mate_feed) { should include(older_matepost) }
    end
  end

end
