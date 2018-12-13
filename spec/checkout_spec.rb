require './checkout'

RSpec.describe Checkout do
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
