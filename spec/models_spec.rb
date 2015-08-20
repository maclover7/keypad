require "spec_helper"

describe Keypad::Models do

  it "should persist provider names" do
    class Twitter < OmniAuth::Strategies::OAuth2; end

    expect do
      OmniAuth::Builder.new(nil) do
        provider ::Twitter
      end
    end

    Keypad::Models.keypad(:twitter)
    expect(Keypad::Models.keypad(:twitter)).to eq(
      {
        :approved => ["twitter"]
      }
    )
  end

  it "raises a helpful LoadError message if it can't find the class" do
    expect {
      Keypad::Models.keypad(:lorax)
    }.to raise_error(LoadError, "Could not find matching strategy for lorax. You may need to install an additional gem (such as omniauth-lorax).")
  end

end
