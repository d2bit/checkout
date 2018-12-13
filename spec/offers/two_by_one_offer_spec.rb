require './item'
require './amount'
require './offers/two_by_one_offer'

RSpec.describe Offers::TwoByOneOffer do
  let(:item) { Item.new('IT1', 'An Item', Amount.new(100, 'EUR')) }
  let(:another_item) { Item.new('IT2', 'Another Item', Amount.new(550, 'EUR')) }

  describe '#valid_for?' do
    it 'returns true when the offer can be applied to the item' do
      offer = described_class.new(item)

      valid = offer.valid_for?(item)

      expect(valid).to eq(true)
    end

    it 'returns false when the offer cannot be applied to the item' do
      offer = described_class.new(item)

      valid = offer.valid_for?(another_item)

      expect(valid).to eq(false)
    end
  end

  describe '#total_for' do
    it 'computes the total without applying the offer' do
      offer = described_class.new(item)
      checkout = [item, another_item]
      expected_amount = Amount.new(100, 'EUR')

      amount = offer.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end

    it 'computes the total with the applied offer' do
      offer = described_class.new(item)
      checkout = [item, another_item, item]
      expected_amount = Amount.new(100, 'EUR')

      amount = offer.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end
  end
end
