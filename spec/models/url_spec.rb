require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:target) }
    it { is_expected.to validate_presence_of(:short) }
    it { is_expected.to validate_uniqueness_of(:short) }
    it 'validates that target is a valid URL' do
      should allow_value('http://example.com').for(:target)
      should allow_value('https://example.com').for(:target)
      should_not allow_value('invalid-url').for(:target)
    end
  end

  describe 'normalize_target' do
    context 'when target starts with www' do
      let(:url) { Url.new(target: 'www.example.com') }

      it 'prepends http://' do
        url.valid?
        expect(url.target).to eq('http://www.example.com')
      end
    end

    context 'when target already has http://' do
      let(:url) { Url.new(target: 'http://www.example.com') }

      it 'does not prepend http://' do
        url.valid?
        expect(url.target).to eq('http://www.example.com')
      end
    end

    context 'when target already has https://' do
      let(:url) { Url.new(target: 'https://www.example.com') }

      it 'does not prepend http://' do
        url.valid?
        expect(url.target).to eq('https://www.example.com')
      end
    end

    context 'when target is blank' do
      let(:url) { Url.new(target: '') }

      it 'does not prepend http://' do
        url.valid?
        expect(url.target).to eq('')
      end
    end
  end

  describe '#to_param' do
    let(:url) { Url.new(short: 'abc123') }

    it 'returns the short attribute as the parameter' do
      expect(url.to_param).to eq('abc123')
    end
  end
end
