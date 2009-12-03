class FiniteFieldElement
	attr_reader :field, :value

	def initialize(value, field)
		@field = field
		@char = @field.char
		@value = value
	end

	def +(other)
		other = other.in(@field)
		return FiniteFieldElement.new((@value+other.value) % @char, @field)
	end

	def -(other)
		other = other.in(@field)
		inverse = @char - other.value
		return FiniteFieldElement.new((@value+inverse) % @char, @field)
	end

	def -@
		FiniteFieldElement.new((@char - @value) % @char)
	end

	def *(other)
		other = other.in(@field)
		return FiniteFieldElement.new((@value*other.value) % @char, @field)
	end

	def /(other)
		#brute force search, could be made faster by using euclids algorithm
		other = other.in(@field)
		inverse = 1.upto(@char-1).find {|i| (i*other.value) % @char == 1}
		return FiniteFieldElement.new((@value*inverse) % @char, @field)
	end

	def in(field)
		if field == @field
			return self
		else
			raise "Cant convert from #{@field} to #{field}"
		end
	end

	def in?(field)
		return @field == field
	end

	def ==(other)
		@value == other.value
	end

	def to_s(base = 10)
		@value.to_s(base)
	end
end
