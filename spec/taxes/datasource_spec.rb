# frozen_string_literal: true

RSpec.describe Taxes::Datasource do
  describe '#load_tax_brackets' do
    subject(:brackets) { described_class.load_tax_brackets(filename) }
    let(:filename)     { 'spec/fixtures/brackets.json' }

    let(:parsed_brackets) do
      [
        {
          lower_income_limit: 0,
          tax_rate:           0
        }
      ]
    end

    it { is_expected.to match(parsed_brackets) }
  end

  describe '#load_incomes' do
    subject(:incomes)    { described_class.load_incomes(filename) }
    let(:filename)       { 'spec/fixtures/incomes.txt' }
    let(:parsed_incomes) { [60_000] }
    it                   { is_expected.to eq(parsed_incomes) }
  end
end
