# frozen_string_literal: true

RSpec.describe Taxes::Engine do
  let(:brackets) do
    [
      Taxes::Bracket.new(
        lower_income_limit:      0,
        upper_income_limit: 10_000,
        tax_rate:                0
      ),
      Taxes::Bracket.new(
        lower_income_limit: 10_000,
        upper_income_limit: 20_000,
        tax_rate:             0.10
      ),
      Taxes::Bracket.new(
        lower_income_limit: 20_000,
        upper_income_limit: 50_000,
        tax_rate:             0.20
      ),
      Taxes::Bracket.new(
        lower_income_limit: 50_000,
        tax_rate:             0.30
      )
    ]
  end

  let(:instance) { described_class.new(brackets: brackets) }

  describe '#taxes_due' do
    subject(:taxes_due) { instance.taxes_due(income) }

    context '$10,000 income' do
      let(:income) { 10_000 }
      it { is_expected.to eq(0) }
    end

    context '$20,000 income' do
      let(:income) { 20_000 }
      it { is_expected.to eq(1_000) }
    end

    context '$50,000 income' do
      let(:income) { 50_000 }
      it { is_expected.to eq(7_000) }
    end

    context '$60,000 income' do
      let(:income) { 60_000 }
      it { is_expected.to eq(10_000) }
    end
  end
end
