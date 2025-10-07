%% main code

function visualize_velocities()
    
    % construct / organize inputs
    [vertex_coords, leg_params] = Strandbeest_inputs();
    theta = linspace(0, 2*pi, 200);

    % analytical / lin alg calculations
    [dx_tip, dy_tip] = tipvel_analytical(vertex_coords, leg_params, theta);

    % experimental computations
    [exp_dx, exp_dy] = compute_exp_vels(vertex_coords, leg_params, theta);
    
    % plot results
    clf; figure();
    sgtitle("Component Velocities of Strandbeest Leg")

    subplot(2, 1, 1); 
    plot(theta', dx_tip', "k", LineWidth=2, DisplayName="Analytical"); hold on;
    plot(theta', exp_dx', "--", LineWidth=2, DisplayName="Experimental")
    title("Horizontal velocity of Strandbeest leg tip")
    xlabel("Theta (radians)"); ylabel("Horizontal velocity")
    ylim([-60, 40]); legend()

    subplot(2, 1, 2); 
    plot(theta, dy_tip, "k", LineWidth=2, DisplayName="Analytical"); hold on;
    plot(theta, exp_dy, "--", LineWidth=2, DisplayName="Experimental")
    title("Vertical velocity of Strandbeest leg tip")
    xlabel("Theta (radians)"); ylabel("Vertical velocity")
     ylim([-40, 40]); legend()

end

%% helper func to calc analytical leg tip velocities 
% use lin alg (process and math fully described in Strandbeest doc)
% to calculate the velocity at each vertex. Select velocities for leg tip

function [dxtip_vals, dytip_vals] = tipvel_analytical(vertex_coords, leg_params, theta)
    
    % make containers
    dxtip_vals = zeros(length(theta), 1);
    dytip_vals = zeros(length(theta), 1);

    for i = 1:length(theta)
        
        % get theta value
        th = theta(i);

        % compute velocities of each vertex
        vertex_coords = compute_coords(vertex_coords, leg_params, th);
        dVdtheta = compute_velocities(vertex_coords, leg_params, th);

        % store velocities for the leg tip
        dxtip_vals(i) = dVdtheta(13);
        dytip_vals(i) = dVdtheta(14);

    end
end

%% helper func to calc experimental leg tip velocities 
% given theta, calc position a little before and a little after
% then approximate rate of change

function [exp_dx_vals, exp_dy_vals] = compute_exp_vels(vertex_coords, leg_params, theta)

    % set step value
    h = 0.001;  % radians 

    % make containers
    exp_dx_vals = zeros(length(theta), 1);
    exp_dy_vals = zeros(length(theta), 1);

    % approximate vel for each theta value
    for i = 1:length(theta)
        
        % get theta value
        th = theta(i);

        % calc vertext coords around theta
        pos_minus = compute_coords(vertex_coords, leg_params, th-h);
        pos_plus = compute_coords(vertex_coords, leg_params, th+h);

        % isolate leg tip positions
        dx_vals = [pos_minus(13), pos_plus(13)];
        dy_vals = [pos_minus(14), pos_plus(14)];

        % calc & store approx velocities
        exp_dx_vals(i) = diff(dx_vals)/(2*h);
        exp_dy_vals(i) = diff(dy_vals)/(2*h);
    end

end

%% initialize & construct Strandbeest inputs

function [vertex_coords_guess, leg_params] = Strandbeest_inputs()
    
    vertex_coords_guess = [[ 0; 50];    ... %vertex 1 guess
                            [ -50; 0];  ... %vertex 2 guess
                            [ -50; 50]; ... %vertex 3 guess
                            [-100; 0];  ... %vertex 4 guess
                            [-100; -50];... %vertex 5 guess
                            [ -50; -50];... %vertex 6 guess
                            [ -50; -100]];  %vertex 7 guess
    
    % initialize leg_params structure
    leg_params = struct();
    leg_params.num_linkages = 10;   % number of links in linkage
    leg_params.crank_length = 15.0; % length of crank shaft
    
    % number of vertices in linkage
    leg_params.num_vertices = 7;
    % fixed position coords of vertex 0
    leg_params.vertex_pos0 = [0;0];
    % fixed position coords of vertex 2
    leg_params.vertex_pos2 = [-38.0;-7.8];
    
    
    % matrix relating links to vertices
    leg_params.link_to_vertex_list = ...
        [ 1, 3;... %link 1 adjacency
        3, 4;... %link 2 adjacency
        2, 3;... %link 3 adjacency
        2, 4;... %link 4 adjacency
        4, 5;... %link 5 adjacency
        2, 6;... %link 6 adjacency
        1, 6;... %link 7 adjacency
        5, 6;... %link 8 adjacency
        5, 7;... %link 9 adjacency
        6, 7 ]; %link 10 adjacency
   
    % list of lengths for each link in the leg mechanism
    leg_params.link_lengths = ...
        [ 50.0,... %link 1 length
        55.8,... %link 2 length
        41.5,... %link 3 length
        40.1,... %link 4 length
        39.4,... %link 5 length
        39.3,... %link 6 length
        61.9,... %link 7 length
        36.7,... %link 8 length
        65.7,... %link 9 length
        49.0 ]; %link 10 length

end

