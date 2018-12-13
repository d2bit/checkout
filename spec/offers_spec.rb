require './offers'

RSpec.describe Offers do
  describe '.no_offer_on' do
    it 'creates a NoOffer instance' do
      item = double(:item)

      offer = described_class.no_offer_on(item)

      expect(offer).to be_a(Offers::NoOffer)
    end
  end

  describe '.two_by_one_on' do
    it 'creates a TwoByOneOffer instance' do
      item = double(:item)

      offer = described_class.two_by_one_on(item)

      expect(offer).to be_a(Offers::TwoByOneOffer)
    end
  end

  describe '.bulk_price_on' do
    it 'creates a BulkPriceOffer instance' do
      item = double(:item)
      amount = double(:amount)

      offer = described_class.bulk_price_on(item, bulk_size: 2, amount: amount)

      expect(offer).to be_a(Offers::BulkPriceOffer)
    end
  end
end
