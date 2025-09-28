%Error function that encodes the link length constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% in the linkage. There are two ways that I would recommend stacking
% the coordinates. You could alternate between x and y coordinates:
% i.e. vertex_coords = [x1;y1;x2;y2;...;xn;y_n], or alternatively
% you could do all the x's first followed by all of the y's
% i.e. vertex_coords = [x1;x2;...xn;y1;y2;...;yn]. You could also do
% something else entirely, the choice is up to you.
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.link_lengths is a list of linakge lengths
% and leg_params.link_to_vertex_list is a two column matrix where
% leg_params.link_to_vertex_list(i,1) and
% leg_params.link_to_vertex_list(i,2) are the pair of vertices connected
% by the ith link in the mechanism
%OUTPUTS:
%length_errors: a column vector describing the current distance error of the ith
% link specifically, length_errors(i) = (xb-xa)ˆ2 + (yb-ya)ˆ2 - d_iˆ2
% where (xa,ya) and (xb,yb) are the coordinates of the vertices that
% are connected by the ith link, and d_i is the length of the ith link
function length_errors = link_length_error_func(vertex_coords, leg_params)

x_coords = vertex_coords(1);
y_coords = vertex_coords(2);

link_lengths = leg_params.link_lengths;
link_to_vertex_list = leg_params.link_to_vertex_list;

length_errors = zeros(length(link_lengths),1);
i = 1;

while i <= length(link_lengths)

    vertex_a = link_to_vertex_list(i,1);
    vertex_b = link_to_vertex_list(i,2);

    xa = x_coords(vertex_a);
    ya = y_coords(vertex_a);

    xb = x_coords(vertex_b);
    yb = y_coords(vertex_b);

    d_i = link_lengths(i);

    length_errors(i) = (xb-xa)^2 + (yb-ya)^2 - d_i^2;

    i = i + 1;
end
end
