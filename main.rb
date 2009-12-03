require 'finite_field.rb'
require 'elliptic_curve.rb'
require 'point.rb'
require 'pollard_rho.rb'


f173 = FiniteField.new(173)
e1 = EllipticCurve.new([146, 33], f173)
p1 = Point.new(168, 133, f173).on(e1)
q1 = Point.new(147, 74, f173).on(e1)


f1009 = FiniteField.new(1009)
e2 = EllipticCurve.new([71, 602], f1009)
p2 = Point.new(32, 737, f1009).on(e2)
q2 = Point.new(592, 97, f1009).on(e2)

#k = PollardRho.compute_log(p2, q2, 53, e2)
#puts "=> k is: #{k}"

n = 16843009
f1 = lambda {|x| (1024*x*x + 32767) % n}
f2 = lambda {|x| (2048*x*x + 32767) % n}
#factor = PollardRho.compute_factor(n, f1, 1)
factor = PollardRho.compute_factor(n, f2, 1)

puts "Factoring n=#{n}..."
puts "Found factor: #{factor}"

#puts "Control result: #{p2*k}"
