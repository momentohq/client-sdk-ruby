require 'momento'

RSpec.describe Momento::SetResponse do
  let(:response) { described_class.new }

  it_behaves_like described_class
end
