function [H,J] = hankel(I,n)

%I = I(:);

r = [0:length(I)-1];

k = (pi/length(I))*r;

J = besselj(n,k(:)*r);

h = (2*pi)*I(:).*r(:);

H = (J*h);

end
