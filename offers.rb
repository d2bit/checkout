require_relative './offers/no_offer'
require_relative './offers/two_by_one_offer'

module Offers
  def self.no_offer_on(item)
    NoOffer.new(item)
  end

  def self.two_by_one_on(item)
    TwoByOneOffer.new(item)
  end
end

