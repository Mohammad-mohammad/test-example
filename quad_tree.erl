-module(quad_tree).

-type point() :: {integer(), integer()}.
-export([new/1]).
-type bounding_rect() :: {LeftTop :: point(), RightBottom :: point()}.

-type error() :: {error, Reason :: atom()}.


		

validate_bounds({{X1, Y1}, {X2, Y2}}) ->
        W = erlang:abs(X2 - X1),
        H = erlang:abs(Y2 - Y1),
        W =:= H andalso
        (W band (W - 1)) =:= 0 andalso
        (H band (H - 1)) =:= 0.

get_center({{X1, Y1}, {X2, Y2}}) ->
        {erlang:trunc((X2 - X1) / 2), erlang:trunc((Y2 - Y1) / 2)}.
		

is_in_rect(BoundingRect, Point) ->
        {{X1, Y1}, {X2, Y2}} = BoundingRect,
        {X, Y} = Point,
        X >= X1 andalso X =< X2 andalso
        Y >= Y1 andalso Y =< Y2.