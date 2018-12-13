require './checkout'
require './pricing_rules.rb'
require './item.rb'
require './amount.rb'

RSpec.describe 'Integration' do
  context 'having 1 item checkout' do
    it 'computes the total' do
      green_tea = Item.new('GR1', 'Green tea', Amount.new(311, '£'))
      pricing_rules = PricingRules.new(items: [green_tea])
      expected_price = '£3.11'

      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end
end
