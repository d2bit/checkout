require './checkout'
require './pricing_rules.rb'
require './item.rb'
require './amount.rb'
require './offers.rb'

RSpec.describe 'Integration' do
  let(:green_tea) { Item.new('GR1', 'Green tea', Amount.new(3_11, '£')) }
  let(:strawberries) { Item.new('SR1', 'Strawberries', Amount.new(5_00, '£')) }
  let(:coffee) { Item.new('CF1', 'Coffee', Amount.new(11_23, '£')) }

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

  context 'having 3 or more bulk-price items' do
    it 'computes the total with a bulk price' do
      bulk_price_strawberries = Offers.bulk_price_on(strawberries, bulk_size: 3, amount: Amount.new(4_50, '£'))
      pricing_rules = PricingRules.new(items: [strawberries], offers: [bulk_price_strawberries])
      expected_price = '£13.50'

      co = Checkout.new(pricing_rules)
      co.scan(strawberries)
      co.scan(strawberries)
      co.scan(strawberries)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'having 3 or more bulk-discount items' do
    it 'computes the total with a bulk price' do
      bulk_discount_coffee = Offers.bulk_discount_on(coffee, bulk_size: 3, discount: 2.0/3)
      pricing_rules = PricingRules.new(items: [coffee], offers: [bulk_discount_coffee])
      expected_price = '£22.46'

      co = Checkout.new(pricing_rules)
      co.scan(coffee)
      co.scan(coffee)
      co.scan(coffee)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end
end
