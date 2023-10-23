require "rails_helper"

RSpec.describe NewUserSignUpMailer, type: :mailer do
  describe "new_user_sign_up" do
    let(:mail) { NewUserSignUpMailer.new_user_sign_up }

    it "renders the headers" do
      expect(mail.subject).to eq("New user sign up")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
