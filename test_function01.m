%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like
function [f_val,J] = test_function01(X)
    f1 = @(X) (X(1))^2 + (X(2))^2 - 6 - (X(3))^5;
    f2 = @(X) X(1)*(X(3)) + X(2) -12
    f3 = @(X) sin(X(1) + X(2) + X(3))

    J =
end