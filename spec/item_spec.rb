require './item'

RSpec.describe Item do
  describe '#==' do
    it 'returns true if code match' do
      item = described_class.new('I1', 'Item', double(:amount))
      same_item = described_class.new('I1', 'Item', double(:amount))

      comparison = item == same_item

      expect(comparison).to eq(true)
    end

    it 'returns false if code does not atch' do
      item = described_class.new('I1', 'Item', double(:amount))
      another_item = described_class.new('I2', 'Item', double(:amount))

      comparison = item == another_item

      expect(comparison).to eq(false)
    end
  end
end
