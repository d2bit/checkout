class PricingRules
  def initialize(items: [])
    @items = items
  end

  def total_for(checkout)
    checkout.map do |item|
      item.amount
    end.inject do |sum, amount|
      sum += amount
    end
  end
end
