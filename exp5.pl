% Predicate to test the puzzle solver
test(Plan):-
    % Print initial state of the puzzle
    write('Initialstate:'), nl,
    % Define initial state and print it
    Init = [at(tile4,1), at(tile3,2), at(tile8,3), at(empty,4), at(tile2,5), at(tile6,6), at(tile5,7), at(tile1,8), at(tile7,9)],
    write_solution(Init),
    % Define goal state
    Goal = [at(tile1,1), at(tile2,2), at(tile3,3), at(tile4,4), at(empty,5), at(tile5,6), at(tile6,7), at(tile7,8), at(tile8,9)],
    % Print goal state
    nl, write('Goalstate:'), nl, write(Goal), nl, nl,
    % Solve the puzzle
    solve_puzzle(Init, Goal, Plan).

% Predicate to solve the puzzle
solve_puzzle(State, Goal, Plan):-
    solve(State, Goal, [], Plan).

% Base case: goal state is reached
solve(State, Goal, Plan, Plan):-
    is_subset(Goal, State), nl,
    write_solution(Plan).

% Recursive predicate to solve the puzzle
solve(State, Goal, Sofar, Plan):-
    % Choose an action to perform
    action(Action, Preconditions, Delete, Add),
    % Check if preconditions for the action are met
    is_subset(Preconditions, State),
    % Ensure the action has not been taken before to avoid loops
    \+ member(Action, Sofar),
    % Apply effects of the action to the current state
    delete_elements(Delete, State, Remainder),
    append_list(Add, Remainder, NewState),
    % Recursively solve the puzzle with updated state and plan
    solve(NewState, Goal, [Action|Sofar], Plan).

% Define actions that can be taken to move towards the goal state
action(move(X,Y,Z),
    [at(X,Y), at(empty,Z), is_movable(Y,Z)],
    [at(X,Y), at(empty,Z)],
    [at(X,Z), at(empty,Y)]
).

% Predicate to check if a tile can be moved from one position to another
is_movable(X1, Y1):-
    (1 is X1-Y1); (-1 is X1-Y1); (3 is X1-Y1); (-3 is X1-Y1).

% Predicate to check if a list is a subset of another list
is_subset([H|T], Set):-
    member(H, Set),
    is_subset(T, Set).
is_subset([], _).

% Predicate to remove elements from a list
delete_elements([H|T], CurState, NewState):-
    remove_element(H, CurState, Remainder),
    delete_elements(T, Remainder, NewState).
delete_elements([], CurState, CurState).

% Helper predicate to remove an element from a list
remove_element(X, [X|T], T).
remove_element(X, [H|T], [H|R]):-
    remove_element(X, T, R).

% Predicate to print the solution
write_solution([]).
write_solution([H|T]):-
    write_solution(T),
    write(H), nl.

% Predicate to append lists
append_list([H|T], L1, [H|L2]):-
    append_list(T, L1, L2).
append_list([], L, L).

% Predicate to check if an element is a member of a list
member(X, [X|_]).
member(X, [_|T]):-
    member(X, T).
