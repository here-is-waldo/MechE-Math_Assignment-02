vertex_coords_guess = [...
[ 0; 50];... %vertex 1 guess
[ -50; 0];... %vertex 2 guess
[ -50; 50];... %vertex 3 guess
[-100; 0];... %vertex 4 guess
[-100; -50];... %vertex 5 guess
[ -50; -50];... %vertex 6 guess
[ -50; -100]... %vertex 7 guess
];

%initialize leg_params structure
leg_params = struct();
%number of vertices in linkage
leg_params.num_vertices = 7;
%number of links in linkage
leg_params.num_linkages = 10;
%matrix relating links to vertices
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
6, 7 ... %link 10 adjacency
];

%list of lengths for each link
%in the leg mechanism
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
49.0 ... %link 10 length
];

%length of crank shaft
leg_params.crank_length = 15.0;
%fixed position coords of vertex 0
leg_params.vertex_pos0 = [0;0];
%fixed position coords of vertex 2
leg_params.vertex_pos2 = [-38.0;-7.8];

theta = 0;

test_coords = compute_coords(vertex_coords_guess, leg_params, theta);

coords_matrix = column_to_matrix(test_coords);
scatter(coords_matrix(:, 1), coords_matrix(:, 2))
x_coords =coords_matrix(:, 1);
y_coords = coords_matrix(:, 2);

for i = 1:length(leg_params.link_lengths)
    vertex_a = leg_params.link_to_vertex_list(i,1);
    vertex_b = leg_params.link_to_vertex_list(i,2);

    xa = x_coords(vertex_a);
    ya = y_coords(vertex_a);

    xb = x_coords(vertex_b);
    yb = y_coords(vertex_b);

    d_i = leg_params.link_lengths(i);

    disp((xb-xa)^2 + (yb-ya)^2 - d_i^2)
end