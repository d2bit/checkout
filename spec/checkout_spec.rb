require './checkout'
require './pricing_rules.rb'
require './item.rb'
require './amount.rb'

RSpec.describe Checkout do
  describe 'Integration' do
    it 'computes the total' do
      green_tea = Item.new('GR1', 'Green tea', Amount.new(311, '£'))
      pricing_rules = PricingRules.new(items: [green_tea])
      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq('£3.11')
    end
  end

  describe '#total' do
    it 'delegates to pricing rules' do
      pricing_rules = double(:pricing_rules)
      allow(pricing_rules).to receive(:total_for)

      co = described_class.new(pricing_rules)
      co.total

      expect(pricing_rules).to have_received(:total_for).with([])
    end

    it 'sends the scanned items' do
      pricing_rules = double(:pricing_rules)
      allow(pricing_rules).to receive(:total_for)
      items = ['Green Tea', 'Coffee']

      co = described_class.new(pricing_rules)
      items.each do |item|
        co.scan(item)
      end
      co.total

      expect(pricing_rules).to have_received(:total_for).with(items)
    end
  end
end
