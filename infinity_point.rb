class InfinityPoint
	def +(other)
		return other
	end

	def -(other)
		return CurvePoint.new(other.x, -other.y, other.curve)
	end

	def *(scalar)
		return self
	end

	def eql?(other)
		return other.is_a? InfinityPoint
	end

	def hash
		return 1234
	end

	def to_s
		"<Point at Infinity>"
	end
end
