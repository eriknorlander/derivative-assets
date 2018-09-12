function [qu, qd, u, d] = calibrate(R, sigma,T,n)
delta = T/n;
u = exp(sigma*sqrt(delta));
d = exp(-sigma*sqrt(delta));
qu = (exp(R*delta)-d)/(u-d);
qd = 1-qu;
end