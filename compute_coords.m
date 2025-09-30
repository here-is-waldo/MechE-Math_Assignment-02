%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
% these coords are just a GUESS! It's used to seed Newton's method
%leg_params: a struct containing the parameters that describe the linkage
%theta: the desired angle of the crank
%OUTPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
% these coords satisfy all the kinematic constraints!
function vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta)
    func = @(vertex_coords) linkage_error_func(vertex_coords, leg_params, theta);
    solver_params = struct();
    vertex_coords_root = multi_newton_solver(func, vertex_coords_guess, solver_params);
end

% function error = error_wrapper(vertex_coords, leg_params, theta)
%     error = linkage_error_func(vertex_coords, leg_params, theta);
% end