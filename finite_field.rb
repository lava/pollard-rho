require 'finite_field_element'

class Fixnum
	def in(field)
		return field.get_element(self)
	end
end

class FiniteField
	attr_reader :char, :size

	#construct field with p^n elements
	def initialize(p, n=1)
		@char = p
		@size = p**n
		raise "Not supported yet." if n > 1 || p == 2 || p == 3
	end

	def ==(other)
		return @size == other.size
	end

	def get_element(num)
		return FiniteFieldElement.new(num % @char, self)
	end
end
