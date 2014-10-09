require 'spec_helper'

describe ConfigLoader do
  let(:path) { File.dirname(__FILE__) + '/../../fixtures/simple.yml' }

  it 'loads config with correct environment' do
    config = described_class.load(path, 'production')
    expect(config[:redis]).to eq(host: 'yawsah')
  end
end
