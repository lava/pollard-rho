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

#k = PollardRho.new(p1, q1, 43, e1).compute_log
k = PollardRho.new(p2, q2, 53, e2).compute_log
puts "=> k is: #{k}"

#puts "Control result: #{p2*k}"
