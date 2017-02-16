require 'rails_helper'

describe Message do
  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:reservation) }
    it { is_expected.to belong_to(:author).class_name("User") }
  end

  describe ".by_created_at" do
    let!(:message_1) { create(:message, created_at: Date.current) }
    let!(:message_2) { create(:message, created_at: Date.current + 1.day) }
    let!(:message_3) { create(:message, created_at: Date.current - 1.day) }

    it "returns messages in order of the date and time they were created, newest first" do
      expect(Message.by_created_at).to eq [message_2, message_1, message_3]
    end
  end

  describe "#author_name" do
    let!(:author) { create(:user, first_name: "Han", last_name: "Solo") }
    let!(:message) { create(:message, author: author) }

    it "returns the first name and last initial for the message's author" do
      expect(message.author_name).to eq "Han S."
    end
  end
end
