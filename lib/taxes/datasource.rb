# frozen_string_literal: true

require 'json'

module Taxes
  # Loads the different data sources (tax brackets and income) from files
  module Datasource
    class << self
      # Expects JSON
      def load_tax_brackets(filename)
        file = File.read(filename)
        JSON.parse(file, symbolize_names: true)
      end

      # One income per line
      def load_incomes(filename)
        File.readlines(filename).map(&:chomp).map(&:to_i)
      end
    end
  end
end
