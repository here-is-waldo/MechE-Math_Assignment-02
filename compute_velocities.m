%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)

    link_length_error_vec = @(v_coords) link_length_error_func(v_coords, leg_params);
    
    J = approximate_jacobian(link_length_error_vec, vertex_coords);

    d = leg_params.crank_length;
    dx1 = d * -sin(theta); dy1 = d * cos(theta);
    
    add = eye(4, 14);
    M = [add; J];

    B = zeros(14, 1);
    B(1) = dx1; B(2) = dy1;

    dVdtheta = M\B;

end