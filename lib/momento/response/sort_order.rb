module Momento
  # Represents whether a collection is sorted in ascending or descending fashion.
  class SortOrder
    ASCENDING = :ascending
    DESCENDING = :descending

    def self.valid?(order)
      [ASCENDING, DESCENDING].include?(order)
    end
  end
end
