X = [3; 2; 1];
[f_val,J] = test_function01(X)

Xn = [];
for i = 1:500
    Xn = Xn - inv(J) * Xn * f_val;
end
