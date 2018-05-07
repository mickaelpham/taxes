# frozen_string_literal: true

module Taxes
  # A single bracket, with a lower and (optional) upper income limit,
  # and a tax rate
  class Bracket
    # Generic bracket error
    class Error < StandardError; end

    # When calling #amount_due for an incorrect income
    class IncorrectBracket < Error; end

    attr_reader :lower_income_limit,
                :upper_income_limit,
                :tax_rate

    def initialize(params)
      @lower_income_limit = params.fetch(:lower_income_limit)
      @upper_income_limit = params.fetch(:upper_income_limit, nil)
      @tax_rate           = params.fetch(:tax_rate)
    end

    def amount_due(income)
      raise IncorrectBracket unless include?(income)

      if nominal?(income)
        (income - lower_income_limit) * tax_rate
      else
        max_amount_due
      end
    end

    def nominal?(income)
      if upper_income_limit
        income.between?(lower_income_limit, upper_income_limit)
      else
        income >= lower_income_limit
      end
    end

    def include?(income)
      income >= lower_income_limit
    end

    private

    # NOTE: We memoize the calculated amount here since the tax brackets can be
    #       reused to calculate the total tax amount due for different income.
    def max_amount_due
      @max_amount_due ||= (upper_income_limit - lower_income_limit) * tax_rate
    end
  end
end
