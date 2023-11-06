-module(main).
-export([start/0]).

start() ->
    {ok, Data} = file:consult("data.txt"),
    {Females, Males} = filter(Data, [], []),
    io:format("Result Females: ~p ~nResult Males: ~p ~n", [Females, Males]),
    io:format("Result Females: ~p ~nResult Males: ~p ~n", [quicksort(Females), quicksort(Males)]).


filter([], Females, Males) -> {Females, Males};
filter([User | Rest], Females, Males) ->
    case User of
        {male, _} -> filter(Rest, Females, [User| Males]);
        {female, _} -> filter(Rest, [User| Females], Males)
    end.

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
    {Smaller, Larger} = partition(Pivot,Rest,[],[]),
quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_,[], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
  {_, Head_int} = H,
  {_, Pivot_int} = Pivot,
  if Head_int =< Pivot_int -> partition(Pivot, T, [H|Smaller], Larger);
    Head_int >  Pivot_int -> partition(Pivot, T, Smaller, [H|Larger])
  end.
  