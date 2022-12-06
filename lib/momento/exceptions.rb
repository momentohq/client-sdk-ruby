module Momento
  # Used to indicate an error in the cache name to be rescued
  # and turned into an InvalidArgument respponse.
  # @private
  class CacheNameError < ::ArgumentError
  end
end
