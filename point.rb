require 'finite_field'
require 'curve_point'

class Point
	attr_reader :x, :y, :field

	def initialize(x, y, field)
		@x = x.in(field)
		@y = y.in(field)
		@field = field
	end

	def on(curve)
		return CurvePoint.new(x, y, curve)
	end

	def eql?(other)
		return @x==other.x && @y==other.y && @field==other.field
	end

	def hash
		@x.value ^ (~@y.value)
	end
end
