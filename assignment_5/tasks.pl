:- use_module(library(clpfd)).

payment(Sum, Coins) :-
    maplist(coin_constraint, Coins),
    calculate_sum(Coins, Sum).

coin_constraint(coin(AmountNeeded, _, AmountAvailable)) :-
    AmountNeeded in 0..AmountAvailable.

calculate_sum([], 0).
calculate_sum([coin(AmountNeeded, Value, _) | Tail], Sum) :-
    calculate_sum(Tail, TailSum),
    Sum #= AmountNeeded * Value + TailSum.

distance(c1, c2, 10, 1). distance(c1, c3, 0, 0). distance(c1, c4, 7, 1).
distance(c1, c5, 5, 1). distance(c2, c3, 4, 1). distance(c2, c4, 12, 1).
distance(c2, c5, 20, 1). distance(c3, c4, 0, 0). distance(c3, c5, 0, 0).
distance(c4, c5, 0, 0). distance(c2, c1, 10, 1). distance(c3, c1, 0, 0).
distance(c4, c1, 7, 1). distance(c5, c1, 5, 1). distance(c3, c2, 4, 1).
distance(c4, c2, 12, 1). distance(c5, c2, 20, 1). distance(c4, c3, 0, 0).
distance(c5, c3, 0, 0). distance(c5, c4, 0, 0).

plan(StartCabin, EndCabin, Path, TotalDistance) :-
    explore(StartCabin, EndCabin, [StartCabin], 0, ReversedPath, TotalDistance),
    reverse(ReversedPath, Path).

explore(CurrentCabin, CurrentCabin, VisitedPath, AccumulatedDistance, VisitedPath, AccumulatedDistance).
explore(CurrentCabin, EndCabin, VisitedPath, AccumulatedDistance, FinalPath, TotalDistance) :-
    distance(CurrentCabin, NextCabin, StepDistance, 1),
    \+ member(NextCabin, VisitedPath),
    NewAccumulatedDistance is AccumulatedDistance + StepDistance,
    explore(NextCabin, EndCabin, [NextCabin | VisitedPath], NewAccumulatedDistance, FinalPath, TotalDistance).

bestplan(StartCabin, EndCabin, Path, Distance) :-
    findall((D, P), plan(StartCabin, EndCabin, P, D), Paths),
    sort(Paths, [(Distance, Path) | _]).
