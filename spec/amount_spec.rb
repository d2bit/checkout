require './lib/amount'

RSpec.describe Amount do
  describe '#+' do
    it 'sums 2 instances' do
      amount = described_class.new(1_00, '$')
      expected_sum = described_class.new(2_00, '$')

      sum = amount + amount

      expect(sum).to eq(expected_sum)
    end

    it 'raises an error with distinct currencies' do
      amount = described_class.new(1_00, '$')
      another_ccy_amount = described_class.new(1_00, 'EUR')

      expect { amount + another_ccy_amount }.to raise_error(described_class::NoMatchCurrencyError)
    end
  end

  describe '#times' do
    it 'computes an amount integer multiplication' do
      amount = described_class.new(1_00, '$')
      expected_prod = described_class.new(2_00, '$')

      prod = amount.times(2)

      expect(prod).to eq(expected_prod)
    end
  end

  describe '#==' do
    it 'returns true if cents and symbol match' do
      one_dollar = described_class.new(1_00, '$')
      another_dollar = described_class.new(1_00, '$')

      comparison = one_dollar == another_dollar

      expect(comparison).to eq(true)
    end

    it 'returns false if cents does not match' do
      one_dollar = described_class.new(1_00, '$')
      two_dollars = described_class.new(2_00, '$')

      comparison = one_dollar == two_dollars

      expect(comparison).to eq(false)
    end

    it 'returns false if symbol does not match' do
      one_dollar = described_class.new(1_00, '$')
      one_euro = described_class.new(1_00, 'EUR')

      comparison = one_dollar == one_euro

      expect(comparison).to eq(false)
    end
  end

  describe '#to_s' do
    it 'formats the amount' do
      one_dollar = described_class.new(1_00, '$')
      expected_string = '$1.00'

      string = one_dollar.to_s

      expect(string).to eq(expected_string)
    end
  end
end
