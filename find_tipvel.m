function [dxtip, dytip] = find_tipvel(vertex_coords, leg_params, theta)
    dVdtheta = compute_velocities(vertex_coords, leg_params, theta);
    dxtip = dVdtheta(13);
    dytip = dVdtheta(14);
end