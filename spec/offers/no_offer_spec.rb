require './item'
require './amount'
require './offers/no_offer'

RSpec.describe Offers::NoOffer do
  let(:item) { Item.new('IT1', 'An Item', Amount.new(100, 'EUR')) }
  let(:another_item) { Item.new('IT2', 'Another Item', Amount.new(550, 'EUR')) }

  describe '#valid_for?' do
    it 'returns always true' do
      offer = described_class.new(item)

      valid = offer.valid_for?(item)

      expect(valid).to eq(true)
    end
  end

  describe '#total_for' do
    it 'computes the total without offers' do
      offer = described_class.new(item)
      checkout = [item, another_item, item]
      expected_amount = Amount.new(100, 'EUR').times(2)

      amount = offer.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end
  end
end
