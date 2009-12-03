require 'point'

class PollardRho
	def self.compute_log(p, q, ord_p, curve, bits = 2)
		#initializing the algorithm
		max = curve.field.size
		pivot_points = {}
		visited_points = {}
		a_coefficients = []
		b_coefficients = []
		#choose random points for the partition
		0.upto(2**bits-1) do |i|
			bit_pattern = i.to_s(2).rjust(@bits, '0')
			ai = rand(max)
			bi = rand(max)
			point = p*ai + q*bi
			pivot_points[bit_pattern] = point
			visited_points[point] = [ai, bi]
			a_coefficients << ai
			b_coefficients << bi
		end

		#start the algorithm
		a0 = rand(max)
		b0 = rand(max)
		ai, bi = a0, b0
		point = p*a0 + q*b0
		while(true)
			if point.is_a? InfinityPoint
				bit_pattern = "0"*bits
			else
				bit_pattern = point.x.to_s(2).rjust(bits, '0')[-bits..-1]
			end
			point = point + pivot_points[bit_pattern]
			i = bit_pattern.to_i(2)
			ai += a_coefficients[i]
			bi += b_coefficients[i]
			break if visited_points[point]
			puts "Adding <#{point}> to visited."
			visited_points[point] = [ai, bi]
		end

		uj, vj = ai, bi
		ui, vi = visited_points[point]
		puts "Found collision: #{uj - ui}P + #{vj - vi}Q = 0."
		inverse = 1.upto(ord_p).find {|i| (i*(vj-vi)) % ord_p==1}
		return (-(uj-ui)*inverse) % ord_p
	end

	def self.compute_factor(n, f=nil, x0=2)
		f = lambda {|x| (x*x + 1) % n} unless f
		x = x0
		y = f.call(x0)
		d = 1

		while(d == 1)
			x = f.call(x)
			y = f.call(f.call(y))
			abs = (x-y).abs
			d = n.gcd(abs)
			puts "x=#{x}, y=#{y}, gcd=#{d}"
		end

		if d==n
			puts "Algorithm failed, try again."
			return nil
		else
			return d
		end
	end
end
