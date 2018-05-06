# frozen_string_literal: true

module Taxes
  # A single bracket, with a lower and (optional) upper income limit,
  # and a tax rate
  class Bracket
    # Generic bracket error
    class Error < StandardError; end

    # When the upper income limit is not defined
    class NoUpperIncomeLimit < Error; end

    attr_reader :lower_income_limit,
                :upper_income_limit,
                :tax_rate

    def initialize(params)
      @lower_income_limit = params.fetch(:lower_income_limit)
      @upper_income_limit = params.fetch(:upper_income_limit, nil)
      @tax_rate           = params.fetch(:tax_rate)
    end

    def max_amount_due
      raise NoUpperIncomeLimit unless upper_income_limit
      @max_amount_due ||= (upper_income_limit - lower_income_limit) * tax_rate
    end
  end
end
