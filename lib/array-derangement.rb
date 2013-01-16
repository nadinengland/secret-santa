class Array
	# Calculates all the possible derangements. A derangement is a permutation of
	# elements of a set (in our case, just a enumerable) such that none of the
	# elements appear in their original position.
	#
	# See http://en.wikipedia.org/wiki/Derangement for more information.
	# 
	# @return [Array] all derangements.
  def derangement
    permutation.select do |perm|
      zip(perm).all? { |a, b| a != b }
    end
  end
end