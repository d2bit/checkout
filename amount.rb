class Amount
  attr_reader :cents, :symbol

  def initialize(cents, symbol)
    @cents = cents
    @symbol = symbol
  end

  def +(amount)
    raise NoMatchCurrencyError if symbol != amount.symbol

    Amount.new(cents + amount.cents, symbol)
  end

  def ==(amount)
    symbol == amount.symbol && cents == amount.cents
  end

  def to_s
    "%s%.2f" % [symbol, cents/100.0]
  end

  class NoMatchCurrencyError < StandardError; end
end
