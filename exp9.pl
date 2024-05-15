% Define the initial state
start([3,3,left,0,0]).
% Define the goal state
goal([0,0,right,3,3]).

% Predicate to check if a state is legal
legal(CL, ML, CR, MR) :-
    ML >= 0, CL >= 0, MR >= 0, CR >= 0,
    (ML >= CL ; ML = 0),
    (MR >= CR ; MR = 0).

% Define possible moves
move([CL, ML, left, CR, MR], [CL2, ML2, right, CR2, MR2]) :-
    % Two missionaries cross from left to right
    MR2 is MR + 2,
    ML2 is ML - 2,
    legal(CL, ML2, CR, MR2).

move([CL, ML, left, CR, MR], [CL2, ML, right, CR2, MR]) :-
    % Two cannibals cross from left to right
    CR2 is CR + 2,
    CL2 is CL - 2,
    legal(CL2, ML, CR2, MR).

move([CL, ML, left, CR, MR], [CL2, ML2, right, CR2, MR2]) :-
    % One missionary and one cannibal cross from left to right
    MR2 is MR + 1,
    ML2 is ML - 1,
    CR2 is CR + 1,
    CL2 is CL - 1,
    legal(CL2, ML2, CR2, MR2).

move([CL, ML, left, CR, MR], [CL2, ML2, right, CR2, MR2]) :-
    % One missionary crosses from left to right
    MR2 is MR + 1,
    ML2 is ML - 1,
    legal(CL, ML2, CR, MR2).

move([CL, ML, left, CR, MR], [CL2, ML, right, CR2, MR2]) :-
    % One cannibal crosses from left to right
    CR2 is CR + 1,
    CL2 is CL - 1,
    legal(CL2, ML, CR2, MR).

% Define the rest of the move predicates similarly

% Define recursive path predicate
path([0, 0, right, 3, 3], [0, 0, right, 3, 3], _, []).

path(State, Goal, Visited, [Move|Moves]) :-
    move(State, Next),
    \+ member(Next, Visited),
    path(Next, Goal, [Next|Visited], Moves),
    Move = [State, Next].

% Print the solution
output([]) :- nl.
output([[A,B]|MovesList]) :-
    output(MovesList),
    write(B), write(' -> '), write(A), nl.

% Find the solution for the missionaries and cannibals problem
find :-
    start(Start),
    goal(Goal),
    path(Start, Goal, [Start], Moves),
    output(Moves).
