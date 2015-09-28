require 'spec_helper'

describe ConfigLoader do
  let(:path) { File.dirname(__FILE__) + '/../fixtures/simple.yml' }

  context 'config loaded with production deployment setting' do

    let(:config) { described_class.load(path, 'production') }

    it 'exposes production value' do
      expect(config[:some_service]).to eq(host: 'some_service.production.com')
    end
  end

  context 'config loaded with development deployment setting' do

    let(:config) { described_class.load(path, 'development') }

    it 'exposes development value' do
      expect(config[:some_service]).to eq(host: 'localhost')
    end
  end

  context 'with ENV variables declared' do

    let(:config) { described_class.load(path, 'flexible') }

    before do
      ENV['FOO'] = 'foo-value'
    end

    it 'exposes ENV defined value' do
      expect(config[:foo]).to eq('foo-value')
    end

    it 'exposes undefined ENV values as nil' do
      expect(config[:undefine_val]).to be_nil
    end
  end

end
