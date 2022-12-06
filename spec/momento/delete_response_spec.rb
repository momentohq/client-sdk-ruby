require 'momento/response'

RSpec.describe Momento::DeleteResponse do
  let(:response) { described_class.new }

  it_behaves_like described_class
end
