# frozen_string_literal: true

RSpec.describe Taxes::Bracket do
  let(:instance) { described_class.new(params) }

  describe '#nominal?' do
    subject(:nominal?) { instance.nominal?(income) }

    context 'bracket with an upper income limit' do
      let(:params) do
        {
          lower_income_limit: 10_000,
          upper_income_limit: 20_000,
          tax_rate:             0.10
        }
      end

      context 'income is not within the tax bracket limits' do
        let(:income) { 5_000 }
        it { is_expected.to be false }
      end

      context 'income is within the tax bracket limits' do
        let(:income) { 15_000 }
        it { is_expected.to be true }
      end
    end

    context 'bracket without an upper income limit' do
      let(:params) do
        {
          lower_income_limit: 20_001,
          tax_rate:             0.20
        }
      end

      context 'income is not within the tax bracket limits' do
        let(:income) { 5_000 }
        it { is_expected.to be false }
      end

      context 'income is within the tax bracket limits' do
        let(:income) { 25_000 }
        it { is_expected.to be true }
      end
    end
  end

  describe '#include?' do
    subject(:include?) { instance.include?(income) }

    let(:params) do
      {
        lower_income_limit: 20_001,
        tax_rate:             0.20
      }
    end

    context 'income is lower than the tax bracket lower limit' do
      let(:income) { 20_000 }
      it { is_expected.to be false }
    end

    context 'income is higher or equal to the tax bracket lower limit' do
      let(:income) { 20_001 }
      it { is_expected.to be true }
    end
  end

  describe '#amount_due' do
    let(:params) do
      {
        lower_income_limit: 10_000,
        upper_income_limit: 20_000,
        tax_rate:             0.10
      }
    end

    subject(:amount_due) { instance.amount_due(income) }

    context 'not the nomimal tax bracket for the given income' do
      let(:income) { 5_000 }

      specify do
        expect { amount_due }.to raise_error(Taxes::Bracket::IncorrectBracket)
      end
    end

    context 'nominal tax bracket for the given income' do
      let(:income) { 15_000 }
      it { is_expected.to eq(500) }
    end

    context 'included but not nominal tax bracket for the given income' do
      let(:income) { 25_000 }
      it { is_expected.to eq(1_000) }
    end
  end
end
