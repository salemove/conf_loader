require 'spec_helper'

describe ConfigLoader do
  describe '.normalize_hash' do
    subject { described_class.normalize_hash(input) }

    context 'when one level hash' do
      let(:input) { {'a' => 'b'} }

      it 'symbolizes keys' do
        should eq(a: 'b')
      end
    end

    context 'when nested hash' do
      let(:input) { {'a' => {'b' => 'c'}} }

      it 'symbolizes keys recursively' do
        should eq(a: {b: 'c'})
      end
    end
  end
end
