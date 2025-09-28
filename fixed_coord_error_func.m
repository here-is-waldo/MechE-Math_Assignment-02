%Error function that encodes the fixed vertex constraints
%INPUTS:
% vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% leg_params: a struct containing the parameters that describe the linkage
% theta: the current angle of the crank
%OUTPUTS:
% coord_errors: a column vector of height four corresponding to the differences
%               between the current values of (x1,y1),(x2,y2) and
%               the fixed values that they should be




function coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
    coords = column_to_matrix(vertex_coords); 
    v0 = leg_params.vertex_pos0; 
    v2_fixed = leg_params.vertex_pos2; 
    v1_fixed = v0 + leg_params.crank_length * [cos(theta); sin(theta)];
    v1 = coords(1, :)'; 
    v2 = coords(2, :)'; 
    coord_errors = [ ...
        v1(1) - v1_fixed(1);  
        v1(2) - v1_fixed(2);  
        v2(1) - v2_fixed(1);  
        v2(2) - v2_fixed(2)];
end
