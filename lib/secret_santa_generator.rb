require_relative 'enumerable-derangements'

# A SecretSantaGenerator useful for complex friendship group relationships.
class SecretSantaGenerator
  # Calucations all possible permitations
  # @param [Array] the Secret Santas whom wish to take part
  # @param [Array] 2D array of constraints, with each inner array containing
	#   people who cannot purcahse for each other:
	#
	#       [ [:thomas, :sarah, :ben], [:thomas, :james] ]
	# 
	#   Permutations where Thomas has Sarah, Ben or James will be rejected.
	#   Similary, permutations where Sarah, Ben or James have Thomas will be
	#   rejected. Permutations where Sarah buys for Ben or Ben buys for Sarah
	#   will be rejected also.
  def initialize(santas, constraints = nil)
    @perms = []

    # No permutations for no people
    return unless santas

    # calculate derangements
    @perms = santas.derangements

    # No need to reject permutations if there are nonstraints
    return unless constraints

    # Begin filtering the permutations, rejecting where the Secret Santa has an
    # invalid recipient
    @perms.reject! do |recipients|
	    # Each contraint must be satisfied.
	    constraints.any? do |constraint|

	      # The constraints need to be in reverse too. A constraint
	      # might be A ~> B, but B ~> A needs to be done also.        
	      constraint.permutation(2).any? do |constraint_pair|
	        
	        # Combine the santas and their recipients and make sure none are
	        # buying for a constraint
	        santas.zip(recipients).any? { |match| match == constraint_pair }
	      end
	    end
    end
  end

  # Used to check the validity of the Secret Santa draw
  # @return [Boolean] if any permutations exist
  def valid?
    not @perms.empty?
  end

  # Uses a Random number generator 
  # @param [Number] seed for the random number generator (see Random.new)
  # @return [Array] the recipient selection in the order of the Santas, nil
  #   unless #valid?
  def pick(seed)
    @perms.sample random: Random.new(seed)
  end
end