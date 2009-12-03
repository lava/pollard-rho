class InfinityPoint
	def +(other)
		return other
	end

	def -(other)
		return -other
	end

	def -@
		return self
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
