require './checkout'

RSpec.describe Checkout do
  describe 'Integration' do
    it 'computes the total' do
      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq('£3.11')
    end
  end
end

def pricing_rules
end

def green_tea
end
