require './lib/amount'

RSpec.describe PricingRules do
  describe '#total_for' do
    it 'computes the sum of items amounts' do
      item = double(:item, code: 'IT1', amount: Amount.new(1_50, '$'))
      checkout = [item, item]
      expected_total = Amount.new(3_00, '$')

      pr = described_class.new(items: [item])
      total = pr.total_for(checkout)

      expect(total).to eq(expected_total)
    end

    it 'delegates the item sum to offers' do
      item = double(:item, code: 'IT1', amount: Amount.new(1_50, '$'))
      offer = double(:offer, valid_for?: true)
      allow(offer).to receive(:total_for)
      checkout = [item]

      pr = described_class.new(items: [item], offers: [offer])
      pr.total_for(checkout)

      expect(offer).to have_received(:total_for).with(checkout)
    end
  end
end
