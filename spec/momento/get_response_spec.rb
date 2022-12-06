require 'momento/response'

RSpec.describe Momento::GetResponse do
  let(:response) { described_class.new }

  it_behaves_like described_class do
    let(:superclass_attributes) do
      { value: nil }
    end
  end
end
