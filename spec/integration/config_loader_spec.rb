require 'spec_helper'

describe ConfigLoader do
  let(:path) { File.dirname(__FILE__) + '/../fixtures/simple.yml' }

  context 'config loaded with production deployment setting' do

    before do
      @config = described_class.load(path, 'production')
    end

    it 'exposes production value' do
      expect(@config[:redis]).to eq(host: 'yawsah')
    end
  end

  context 'config loaded with development deployment setting' do

    before do
      @config = described_class.load(path, 'development')
    end

    it 'exposes development value' do
      expect(@config[:redis]).to eq(host: 'localhost')
    end
  end

end
