% Define the possible transitions between nodes
s(a,b).
s(a,c).
s(b,d).
s(b,e).
s(c,f).
s(c,g).
s(d,h).
s(e,i).
s(e,j).
s(f,k).

% Define the goal nodes
goal(f).
goal(j).

% Predicate to solve the problem using breadth-first search
solve(Start, Solution) :-
    bfs([[Start]], Solution).

% Base case: when the current node is a goal node, return the solution path
bfs([[Node|Path]|_], [Node|Path]) :-
    goal(Node).

% Recursive case: extend the current paths and continue breadth-first search
bfs([Path|Paths], Solution) :-
    extend(Path, NewPaths),
    conc(Paths, NewPaths, Paths1),
    bfs(Paths1, Solution).

% Predicate to extend a path by one step
extend([Node|Path], NewPaths) :-
    bagof([NewNode, Node|Path],
          (s(Node, NewNode), \+ member(NewNode, [Node|Path])),
          NewPaths),
    !. % Cut to prevent unnecessary backtracking

extend(_, []). % No more extensions possible

% Predicate to concatenate two lists
conc([], L, L).
conc([X|L1], L2, [X|L3]) :-
    conc(L1, L2, L3).
