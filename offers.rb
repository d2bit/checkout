require_relative './offers/no_offer'
require_relative './offers/two_by_one_offer'
require_relative './offers/bulk_price_offer'

module Offers
  def self.no_offer_on(item)
    NoOffer.new(item)
  end

  def self.two_by_one_on(item)
    TwoByOneOffer.new(item)
  end

  def self.bulk_price_on(item, bulk_size: 0, amount: item.amount)
    BulkPriceOffer.new(item, bulk_size, amount)
  end
end

