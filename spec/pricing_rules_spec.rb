require './amount'

RSpec.describe PricingRules do
  describe '#total_for' do
    it 'computes the sum of items amounts' do
      item = double(:item, code: 'IT1', amount: Amount.new(150, '$'))
      checkout = [item, item]
      expected_total = Amount.new(300, '$')

      pr = described_class.new(items: [item])
      total = pr.total_for(checkout)

      expect(total).to eq(expected_total)
    end
  end
end
