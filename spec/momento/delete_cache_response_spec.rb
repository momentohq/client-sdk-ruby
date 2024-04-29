require 'momento'

RSpec.describe Momento::DeleteCacheResponse do
  let(:response) { described_class.new }

  it_behaves_like described_class
end
