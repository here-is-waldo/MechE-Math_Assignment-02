function Strandbeest_video()
    video_example()
end

function video_example()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    mypath1 = 'C:\Users\lodio\OneDrive - Olin College of Engineering\Desktop\';
    mypath2 = 'Classes\Junior Fall\Orion Math\Assignment-02\MechE-Math_Assignment-02';
    fname='strandbeest_animation.avi';
    input_fname = [mypath1,mypath2,fname];
    
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    %must call open before writing any frames
    open(writerObj);

    % set up the plotting axis
    clf; fig1 = figure(1); hold on; axis equal; axis square;
    xlim([-120, 30]); ylim([-120, 50]);

    % plot initial
    [vertex_coords_guess, leg_params] = Strandbeest_inputs();
    leg_drawing = initialize_leg_drawing(leg_params);
    tangent_plot = init_vel_vec(vertex_coords_guess, leg_params);


    for theta = 0:0.02:(8*pi)
        
        vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta);
        update_leg_drawing(vertex_coords, leg_drawing, leg_params)

        % update the coordinates of the tangent plot
        x = vertex_coords(13); y = vertex_coords(14);

        dVdtheta = compute_velocities(vertex_coords, leg_params, theta);
        xvel = dVdtheta(13); yvel = dVdtheta(14);  

        set(tangent_plot,'xdata', [x, x+(xvel/2)],'ydata', [y, y+(yvel/2)]);


        drawnow;
        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        %write the frame to the video
        writeVideo(writerObj,current_frame);

    end
    
    %must call close after all frames are written
    close(writerObj);

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

%% function to draw velocity vector

function tangent_plot = init_vel_vec(vertex_coords_guess, leg_params)

    theta = 0;
    vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta);
    dVdtheta = compute_velocities(vertex_coords, leg_params, theta);
    
    x_pos = vertex_coords(13); y_pos = vertex_coords(14);
    x_vel = dVdtheta(13); y_vel = dVdtheta(14);

    x_plot = [x_pos, x_pos+(x_vel/2)];
    y_plot = [y_pos, y_pos+(y_vel/2)];
    tangent_plot = plot(x_plot, y_plot, 'r', LineWidth=2);

end
