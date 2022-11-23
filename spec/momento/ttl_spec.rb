require 'momento'

RSpec.describe Momento::Ttl do
  let(:input_ttl) { Faker::Number.number }
  let(:ttl) { described_class.new(input_ttl) }

  describe '.to_ttl' do
    subject { described_class.to_ttl(input_ttl) }

    context 'when it is a Momento::Ttl' do
      let(:input_ttl) { described_class.new(1_000) }

      it { is_expected.to eq input_ttl }
    end

    context 'when it is nil' do
      let(:input_ttl) { nil }

      it {
        expect {
          subject
        }.to raise_error(ArgumentError, /is not Numeric/)
      }
    end

    context 'when it is not Numeric' do
      let(:input_ttl) { "whenever" }

      it {
        expect {
          subject
        }.to raise_error(ArgumentError, /is not Numeric/)
      }
    end

    context 'when it is an integer' do
      let(:input_ttl) { 123 }

      it {
        is_expected.to have_attributes(
          seconds: 123,
          milliseconds: 123_000
        )
      }
    end

    context 'when it is a decimal' do
      let(:input_ttl) { 123.456 }

      it {
        is_expected.to have_attributes(
          seconds: 123.456,
          milliseconds: 123_456
        )
      }
    end

    context 'when it is negative' do
      let(:input_ttl) { -0.001 }

      it {
        expect {
          subject
        }.to raise_error(ArgumentError, /is less than 0/)
      }
    end

    context 'when it is zero' do
      let(:input_ttl) { 0 }

      it {
        is_expected.to have_attributes(
          seconds: 0, milliseconds: 0
        )
      }
    end
  end

  describe '#to_s' do
    subject { ttl.to_s }

    let(:input_ttl) { 123 }

    it { is_expected.to eq "123 seconds" }
  end

  describe '#==' do
    subject { ttl == other_ttl }

    context 'when it is a Momento::Ttl with the same time' do
      let(:other_ttl) { described_class.to_ttl(ttl.seconds) }

      it { is_expected.to be true }
    end

    context 'when it is a Momento::Ttl with a different time' do
      let(:other_ttl) { described_class.to_ttl(ttl.seconds + 1) }

      it { is_expected.to be false }
    end

    context 'when it is something else' do
      let(:other_ttl) { "some time" }

      it { is_expected.to be false }
    end
  end
end
