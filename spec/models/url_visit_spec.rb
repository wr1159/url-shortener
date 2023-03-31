require 'rails_helper'

RSpec.describe UrlVisit, type: :model do
  let(:url) { Url.create(target: 'https://example.com', short: 'example') }

  describe 'associations' do
    it { is_expected.to belong_to(:url) }
  end

  describe 'creation' do
    it 'creates a new url visit' do
      expect {
        url.url_visits.create(country: 'Malaysia', city: 'Kuala Lumpur')
      }.to change { UrlVisit.count }.by(1)
    end

    it 'creates a new url visit without city' do
      expect {
        url.url_visits.create(country: 'Malaysia')
      }.to change { UrlVisit.count }.by(1)
    end

    it 'creates a new url visit without country' do
      expect {
        url.url_visits.create(city: 'Kuala Lumpur')
      }.to change { UrlVisit.count }.by(1)
    end
  end
end