# frozen_string_literal: true

require 'momento'

RSpec.describe Momento do
  it "has a version number" do
    expect(Momento::VERSION).not_to be_nil
  end
end
