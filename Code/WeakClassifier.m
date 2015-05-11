function e = WeakClassifier(f, p, theta)

%% Function WeakClassifier:
%  Input: f: vector of value of a particular feature extracted from each training image/ Feature response vector
%         p: parity value
%         theta: threshold value
%  Output: e: error
%  
%  Description: g(f(x),p,theta) = +1   if p*f(x) < p*theta
%                                 -1   otherwise

if p * f < p * theta
    e = 1;
else
    e = -1;
end

end