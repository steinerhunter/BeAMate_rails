require 'spec_helper'

describe "Requestpost Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "new request creation" do
    before { visit request_path }

    describe "with invalid information" do

      it "should not create a new request" do
        expect { click_button "Post" }.not_to change(Requestpost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'requestpost_requested_item', with: "Some tablet"}
      before { fill_in 'requestpost_willing_to_pay', with: "50$"}
      before { fill_in 'requestpost_content', with: "Lorem Ipsum"}
      it "should create a requestpost" do
        expect { click_button "Post" }.to change(Requestpost, :count).by(1)
      end
    end
  end

  describe "requestpost destruction" do
    before { FactoryGirl.create(:requestpost, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a requestpost" do
        expect { click_link "delete" }.to change(Requestpost, :count).by(-1)
      end
    end
  end

end
