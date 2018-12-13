require './lib/offers'

class PricingRules
  def initialize(items: [], offers: [])
    @items = items
    @offers = offers
  end

  def total_for(checkout)
    uniq_items.map do |item|
      offer_for(item).total_for(checkout)
    end.inject do |sum, amount|
      sum += amount
    end
  end

  private

  def offer_for(item)
    @offers.find { |offer| offer.valid_for?(item) } ||
      Offers.no_offer_on(item)
  end

  def uniq_items
    @uniq_items ||= @items.uniq
  end
end
