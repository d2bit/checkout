require './lib/item'
require './lib/amount'
require './lib/offers/two_by_one_offer'

RSpec.describe Offers::TwoByOneOffer do
  let(:item) { Item.new('IT1', 'An Item', Amount.new(1_00, 'EUR')) }
  let(:another_item) { Item.new('IT2', 'Another Item', Amount.new(5_50, 'EUR')) }
  subject { described_class.new(item) }

  describe '#valid_for?' do
    it 'returns true when the offer can be applied to the item' do
      valid = subject.valid_for?(item)

      expect(valid).to eq(true)
    end

    it 'returns false when the offer cannot be applied to the item' do
      valid = subject.valid_for?(another_item)

      expect(valid).to eq(false)
    end
  end

  describe '#total_for' do
    it 'computes the total without applying the offer' do
      checkout = [item, another_item]
      expected_amount = Amount.new(1_00, 'EUR')

      amount = subject.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end

    it 'computes the total with the applied offer' do
      checkout = [item, another_item, item]
      expected_amount = Amount.new(1_00, 'EUR')

      amount = subject.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end
  end
end
