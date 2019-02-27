require 'rails_helper'
RSpec.describe Event, type: :model do

  before do
    User.create(email: "u1@gmail.com",password: "123123",password_confirmation: "123123")
  end

  context "Create" do

    before do
      @event = Event.new(action: "action",issue: 15,title: "title",body: "body",user: User.first)
    end

    it "creating" do
      if @event.save
        expect(Event.all.size).to eq(1)
      else
        expect(Event.all.size).to eq(0)
      end
    end

    it "check value of action" do
      expect(@event.action).to eq("action")
    end

  end
end
