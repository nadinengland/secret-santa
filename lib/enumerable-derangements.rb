module Enumerable
	# Calculates all the possible derangements. A derangement is a permutation of
	# elements of a set (in our case, just a enumerable) such that none of the
	# elements appear in their original position.
	#
	# See http://en.wikipedia.org/wiki/Derangement for more information.
	# 
	# @return [Array] all derangements.
  def derangements
    to_a.permutation.to_a.select! do |permutation|
      to_a.zip(permutation).all? { |a, b| a != b }
    end
  end
end