require 'spec_helper'

describe Matepost do

  let(:user) { FactoryGirl.create(:user)}
  before { @matepost = user.mateposts.build(content: "Lorem Ipsum", flying_to: "United States", flying_from: "Israel",
                                                                                            departing_on:"January 15th, 2013", returning_on: "January 19th, 2013") }

  subject { @matepost }

  it { should respond_to(:content) }
  it { should respond_to(:flying_to) }
  it { should respond_to(:flying_from) }
  it { should respond_to(:departing_on) }
  it { should respond_to(:returning_on) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attribute" do
    it "should not allow access to user_id" do
      expect do
        Matepost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @matepost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when matepost item is blank" do
    before { @matepost.flying_to = "" }
    it { should_not be_valid }
  end

  describe "when willing to pay is blank" do
    before { @matepost.flying_from = "" }
    it { should_not be_valid }
  end

  describe "when matepost item is blank" do
    before { @matepost.departing_on = "" }
    it { should_not be_valid }
  end

  describe "when willing to pay is blank" do
    before { @matepost.returning_on = "" }
    it { should_not be_valid }
  end

  describe "when content is blank" do
    before { @matepost.content = "" }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { @matepost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
