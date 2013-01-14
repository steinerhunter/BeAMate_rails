require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user)}
  before { @micropost = user.microposts.build(content: "Lorem Ipsum", requested_item: "Some tablet", willing_to_pay: "50$") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:requested_item) }
  it { should respond_to(:willing_to_pay) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attribute" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when requested item is blank" do
    before { @micropost.requested_item = "" }
    it { should_not be_valid }
  end

  describe "when requested item is too long" do
    before { @micropost.requested_item = "a" * 26 }
    it { should_not be_valid }
  end

  describe "when willing to pay is blank" do
    before { @micropost.willing_to_pay = "" }
    it { should_not be_valid }
  end

  describe "when willing to pay is too long" do
    before { @micropost.willing_to_pay = "a" * 9 }
    it { should_not be_valid }
  end

  describe "when content is blank" do
    before { @micropost.content = "" }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
