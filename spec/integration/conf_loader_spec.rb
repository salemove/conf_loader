require 'spec_helper'

describe ConfLoader do
  let(:path) { File.dirname(__FILE__) + '/../fixtures/simple.yml' }

  context 'when environment not defined' do
    let(:conf) { described_class.load(path, 'office') }

    it 'raises a key not found error' do
      expect { conf }.to raise_error(described_class::EnvironmentNotFoundError, /Configuration for \`office\` not found at path .*/)
    end
  end

  context 'when accessed key not defined' do
    let(:conf) { described_class.load(path, 'office') }

    it 'raises KeyError' do
      expect{conf[:some_undefined_key]}.to raise_error(KeyError)
    end
  end

  context 'conf loaded with production deployment setting' do

    let(:conf) { described_class.load(path, 'production') }

    it 'exposes production value' do
      expect(conf[:some_service]).to eq(host: 'some_service.production.com')
    end
  end

  context 'conf loaded with development deployment setting' do

    let(:conf) { described_class.load(path, 'development') }

    it 'exposes development value' do
      expect(conf[:some_service]).to eq(host: 'localhost')
    end
  end

  context 'with ENV variables declared' do

    let(:conf) { described_class.load(path, 'flexible') }

    before do
      ENV['FOO'] = 'foo-value'
    end

    it 'exposes ENV defined value' do
      expect(conf[:foo]).to eq('foo-value')
    end

    it 'exposes default value when ENV value not supplied' do
      expect(conf[:var_with_default_not_in_env]).to eq('default_value')
    end

    it 'skips default value when ENV value supplied' do
      expect(conf[:var_with_default_in_env]).to eq('foo-value')
    end
  end

end
