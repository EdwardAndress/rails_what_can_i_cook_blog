require "rails_helper"

RSpec.describe Notifier, :type => :mailer do
  describe "email_friend" do
    let(:mail) { Notifier.email_friend }

    it "renders the headers" do
      expect(mail.subject).to eq("Email friend")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
