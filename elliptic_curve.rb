require 'point'
require 'finite_field'

class EllipticCurve
	attr_reader :field, :a1, :a2, :a3, :a4, :a6

	def initialize(coefficients, field)
		@field = field
		case coefficients.size
		when 2
			@a1 = @a3 = @a2 = 0.in(field)
			@a4 = coefficients[0].in(field)
			@a6 = coefficients[1].in(field)
		when 5
			@a1, @a2, @a3, @a4, @a5 = *coefficients.map{|i| i.in(field) }
		else
			raise "Wrong size of coefficient array"
		end
	end

	def contains?(point)
		return false if point.field != @field

		x = point.x
		y = point.y
		p x, y
		return y*y+@a1*x*y+@a3*y == x*x*x+@a2*x*x+@a4*x+@a6
	end
end
