require './checkout'
require './pricing_rules.rb'
require './item.rb'
require './amount.rb'
require './offers.rb'

RSpec.describe 'Integration' do
  let(:green_tea) { Item.new('GR1', 'Green tea', Amount.new(311, '£')) }

  context 'having 1 item checkout' do
    it 'computes the total' do
      pricing_rules = PricingRules.new(items: [green_tea])
      expected_price = '£3.11'

      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'having 2 of buy-one-get-one-free items' do
    it 'computes the total' do
      two_for_one_on_green_tea = Offers.two_by_one_on(green_tea)
      pricing_rules = PricingRules.new(items: [green_tea], offers: [two_for_one_on_green_tea])
      expected_price = '£3.11'

      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end
end
