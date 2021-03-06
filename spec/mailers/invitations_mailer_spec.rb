require "spec_helper"

describe InvitationsMailer do
  describe "invitation" do
    let(:mail) { InvitationsMailer.invitation }

    it "renders the headers" do
      mail.subject.should eq("Invitation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
