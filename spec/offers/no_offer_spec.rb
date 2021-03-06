require './lib/item'
require './lib/amount'
require './lib/offers/no_offer'

RSpec.describe Offers::NoOffer do
  let(:item) { Item.new('IT1', 'An Item', Amount.new(1_00, 'EUR')) }
  let(:another_item) { Item.new('IT2', 'Another Item', Amount.new(5_50, 'EUR')) }
  subject { described_class.new(item) }

  describe '#valid_for?' do
    it 'returns always true' do
      valid = subject.valid_for?(item)

      expect(valid).to eq(true)
    end
  end

  describe '#total_for' do
    it 'computes the total without offers' do
      checkout = [item, another_item, item]
      expected_amount = Amount.new(1_00, 'EUR').times(2)

      amount = subject.total_for(checkout)

      expect(amount).to eq(expected_amount)
    end
  end
end
