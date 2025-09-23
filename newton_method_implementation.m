x_guess = randn(3,1)

solver_params.numerical_diff = 0;
[X_root, successes] = multi_newton_solver(@test_function01, x_guess, solver_params);

[f_val, J] = test_function01(X_root);
disp(f_val)

