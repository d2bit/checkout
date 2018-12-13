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
end
