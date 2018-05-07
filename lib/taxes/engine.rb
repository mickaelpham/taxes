# frozen_string_literal: true

module Taxes
  # Holds a set of tax brackets and return the tax amount due for a given income
  class Engine
    attr_reader :brackets

    def initialize(params)
      @brackets = params.fetch(:brackets, [])
    end

    def taxes_due(income)
      brackets
        .select { |bracket| bracket.include?(income) }
        .map    { |included_bracket| included_bracket.taxes_due(income) }
        .reduce(:+)
    end
  end
end
