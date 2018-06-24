This project solves the following Boundary Value Problem (BVP):

Find u: [0, 1] -> R so that:

u''(x) + Ku(x) - x^2 = 0
		u(0) = v
	       u'(1) = w

for x in the domain: ]0,1[
where K = pi^2, u = (K^2-2)/K^2 and w = 2/K.

The aim is to solve the problem using the finite element method (FEM).