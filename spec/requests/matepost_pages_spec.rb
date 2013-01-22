require 'spec_helper'

describe "Matepost Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "new matepost creation" do
    before { visit mate_path }

    describe "with invalid information" do

      it "should not create a new matepost" do
        expect { click_button "Post" }.not_to change(Matepost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'matepost_flying_to', with: "United States"}
      before { fill_in 'matepost_flying_from', with: "Israel"}
      before { fill_in 'matepost_departing_on', with: "January 15th, 2013"}
      before { fill_in 'matepost_returning_on', with: "January 19th, 2013"}
      before { fill_in 'matepost_content', with: "Lorem Ipsum"}
      it "should create a matepost" do
        expect { click_button "Post" }.to change(Matepost, :count).by(1)
      end
    end
  end

  describe "matepost destruction" do
    before { FactoryGirl.create(:matepost, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a matepost" do
        expect { click_link "delete" }.to change(Matepost, :count).by(-1)
      end
    end
  end

end
