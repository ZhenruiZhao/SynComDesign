function value = safeDivide(numerator, denominator)
%SAFEDIVIDE Divide while returning NaN for zero or missing denominators.
if isempty(denominator) || denominator == 0 || isnan(denominator)
    value = NaN;
else
    value = numerator ./ denominator;
end
end
