% Define the edges between nodes with their corresponding weights
edge(a, b, 3).
edge(a, c, 5).
edge(a, d, 7).
edge(a, e, 8).
edge(b, c, 9).
edge(b, d, 10).
edge(b, e, 3).
edge(c, d, 5).
edge(c, e, 8).
edge(d, e, 6).
edge(b, a, 3).
edge(c, a, 4).
edge(d, a, 2).
edge(e, a, 7).
edge(c, b, 4).
edge(d, b, 6).
edge(e, b, 3).
edge(d, c, 5).
edge(e, c, 8).
edge(e, d, 6).
edge(a, h, 2).
edge(h, d, 1).

% Predicate to find the length of a list
len([], 0).
len([_|T], N) :- len(T, X), N is X + 1.

% Predicate to find the best path
best_path(Visited, Total) :- path(a, a, Visited, Total).

% Predicate to find a path between two nodes
path(Start, Fin, Visited, Total) :-
    path(Start, Fin, [Start], Visited, 0, Total).

path(Start, Fin, CurrentLoc, Visited, Costn, Total) :-
    edge(Start, StopLoc, Distance),
    NewCostn is Costn + Distance,
    \+ member(StopLoc, CurrentLoc),
    path(StopLoc, Fin, [StopLoc|CurrentLoc], Visited, NewCostn, Total).

% When the destination is reached, check if all nodes are visited and compute the total distance
path(Start, Fin, CurrentLoc, Visited, Costn, Total) :-
    edge(Start, Fin, Distance),
    reverse([Fin|CurrentLoc], Visited),
    len(Visited, Q),
    (Q \= 7 -> Total is 100000; Total is Costn + Distance).

% Predicate to find the shortest path
shortest_path(Path) :-
    setof(Cost-Path, best_path(Path, Cost), Holder),
    pick(Holder, Path).

% Predicate to find the best path in a list of paths
best(Cost-Holder, Bcost-Bholder, Cost-Holder) :- Cost < Bcost, !.
best(_, X, X).

% Predicate to pick the best path
pick([Cost-Holder|R], X) :-
    pick(R, Bcost-Bholder),
    best(Cost-Holder, Bcost-Bholder, X),
    !.
pick([X], X).
