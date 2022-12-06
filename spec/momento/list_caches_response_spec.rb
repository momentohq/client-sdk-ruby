require 'momento/response'

RSpec.describe Momento::ListCachesResponse do
  it_behaves_like described_class do
    let(:response) { described_class.new }
  end
end
