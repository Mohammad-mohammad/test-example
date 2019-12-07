-module(quad_tree).

-type point() :: {integer(), integer()}.
-export([new/1]).
-type bounding_rect() :: {LeftTop :: point(), RightBottom :: point()}.

-type error() :: {error, Reason :: atom()}.

new(Bounds) ->
        case validate_bounds(Bounds) of
          true ->
            {ok, #qtree_node { point = get_center(Bounds),
                               bounds = Bounds,
                               nodes = [],
                               val = undefined }};
          false ->
            {error, not_power_of_2}
        end.
		
validate_bounds({{X1, Y1}, {X2, Y2}}) ->
        W = erlang:abs(X2 - X1),
        H = erlang:abs(Y2 - Y1),
        W =:= H andalso
        case W =:= H of
          true ->
            case (W band (W - 1)) of
              0 ->
                case (H band (H - 1)) of
                  0 ->
                    {ok, valid};
                  _ ->
                    {error, height_not_power_of_2}
                end;
              _ ->
                {error, width_not_power_of_2}
            end;
          false ->
            {error, sides_not_equal}
        end.

get_center({{X1, Y1}, {X2, Y2}}) ->
        {erlang:trunc((X2 - X1) / 2), erlang:trunc((Y2 - Y1) / 2)}.