require 'finite_field_element.rb'
require 'infinity_point.rb'

class CurvePoint
	attr_reader :x, :y, :curve

	def initialize(x, y, curve)
		@curve = curve
		@field = curve.field
		if x.is_a?(Fixnum) && y.is_a?(Fixnum)
			@x = x.in(@field)
			@y = y.in(@field)
		elsif x.is_a?(FiniteFieldElement) && y.is_a?(FiniteFieldElement)
			@x = x
			@y = y
		else
			raise "Invalid values for x and y"
		end
	end

	def +(other)
		if other.is_a? InfinityPoint
			return self
		elsif @x == other.x && @y != other.y
			return InfinityPoint.new
		elsif @x == other.x && @y == other.y
			m = (@x*@x*3 + @curve.a2*2*@x + @curve.a4 - @curve.a1)/(@y*2)
		else
			m = (@y - other.y) / (@x - other.x)
		end
		x3 = m*m - @curve.a2 - @x - other.x
		y3 = m*x3 + @y - m*@x
		return CurvePoint.new(x3, 0.in(@field) - y3, @curve)
	end

	def -(other)
		other + CurvePoint.new(@x, 0.in(@field) - @y, @curve)
	end

	#could be made faster by using successive squaring
	def *(scalar)
		return 1.upto(scalar-1).reduce(self) {|sum, i| sum + self }
	end

	def to_s
		"Curve point: x=#{@x}, y=#{@y}"
	end

	def inspect
		self.to_s
		#"Curve point: x=#{@x}, y=#{@y}"
	end

	def eql?(other)
		return @x==other.x && @y==other.y #&& @curve==other.curve
	end

	def hash
		@x.value ^ (~@y.value)
	end
end
