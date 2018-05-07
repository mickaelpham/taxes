module Taxes
  # Loads the different data sources (tax brackets and income) from files
  module Datasource
    class << self
      # Expects JSON
      def load_tax_brackets(filename)
      end

      # One income per line
      def load_incomes(filename)
      end
    end
  end
end
