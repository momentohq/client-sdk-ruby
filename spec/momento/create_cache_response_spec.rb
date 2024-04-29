require 'momento'

RSpec.describe Momento::CreateCacheResponse do
  let(:response) { described_class.new }

  it_behaves_like described_class
end
