require 'spec_helper'

describe Requestpost do

  let(:user) { FactoryGirl.create(:user)}
  before { @requestpost = user.requestposts.build(content: "Lorem Ipsum", requested_item: "Some tablet", willing_to_pay: "50$") }

  subject { @requestpost }

  it { should respond_to(:content) }
  it { should respond_to(:requested_item) }
  it { should respond_to(:willing_to_pay) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attribute" do
    it "should not allow access to user_id" do
      expect do
        Requestpost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @requestpost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when requested item is blank" do
    before { @requestpost.requested_item = "" }
    it { should_not be_valid }
  end

  describe "when requested item is too long" do
    before { @requestpost.requested_item = "a" * 26 }
    it { should_not be_valid }
  end

  describe "when willing to pay is blank" do
    before { @requestpost.willing_to_pay = "" }
    it { should_not be_valid }
  end

  describe "when willing to pay is too long" do
    before { @requestpost.willing_to_pay = "a" * 9 }
    it { should_not be_valid }
  end

  describe "when content is blank" do
    before { @requestpost.content = "" }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { @requestpost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
