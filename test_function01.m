%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like
function [f_val,J] = test_function01(X)
    f1 = (X(1))^2 + (X(2))^2 - 6 - (X(3))^5;
    f2 = X(1)*(X(3)) + X(2) -12;
    f3 = sin(X(1) + X(2) + X(3));

    f1_partial_dx1 = 2*X(1);
    f1_partial_dx2 = 2*X(2);
    f1_partial_dx3 = 5*(X(3)^2);

    f2_partial_dx1 = X(3);
    f2_partial_dx2 = 1;
    f2_partial_dx3 = X(1);

    f3_partial_dx1 = cos(X(1));
    f3_partial_dx2 = cos(X(2));
    f3_partial_dx3 = cos(X(1));
    
    f_val = [f1, f2, f3];
    J = [f1_partial_dx1, f1_partial_dx2, f1_partial_dx3;
        f2_partial_dx1, f2_partial_dx2, f2_partial_dx3;
        f3_partial_dx1, f3_partial_dx2, f3_partial_dx3];
end