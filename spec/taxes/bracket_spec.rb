# frozen_string_literal: true

RSpec.describe Taxes::Bracket do
  let(:instance) { described_class.new(params) }

  describe '#max_amount_due' do
    subject(:max_amount_due) { instance.max_amount_due }

    context 'first bracket (not taxed)' do
      let(:params) do
        {
          lower_income_limit:      0,
          upper_income_limit: 10_000,
          tax_rate:                0
        }
      end

      it { is_expected.to eq(0) }
    end

    context 'second bracket (with lower and upper income limits)' do
      let(:params) do
        {
          lower_income_limit: 10_000,
          upper_income_limit: 20_000,
          tax_rate:             0.10
        }
      end

      it { is_expected.to eq(1_000) }
    end

    context 'open bracket (no upper income limit)' do
      let(:params) do
        {
          lower_income_limit: 20_000,
          tax_rate:             0.20
        }
      end

      specify do
        expect { max_amount_due }
          .to raise_error(Taxes::Bracket::NoUpperIncomeLimit)
      end
    end
  end
end
