
leg_params = struct();
leg_params.crank_length = 15.0;
leg_params.vertex_pos0 = [0;0];
leg_params.vertex_pos2 = [-38.0;-7.8];

theta = pi/2; 

% Expected positions:
% v1 should be at (0,15)
% v2 should be at (-38.0,-7.8)

vertex_coords = [  0, -38, 0, 0, 0, 0, 0;   % x's
                  15, -7.8, 0, 0, 0, 0, 0]; % y's

errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
