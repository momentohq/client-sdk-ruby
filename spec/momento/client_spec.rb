# frozen_string_literal: true

RSpec.describe Momento::Client do
  it "has a version number" do
    expect(Momento::Client::VERSION).not_to be_nil
  end
end
