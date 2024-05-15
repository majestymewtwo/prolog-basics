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

% Define a predicate to check if an element is a member of a list
mem(X,[X|_]).
mem(X,[_|Tail]) :- mem(X,Tail).

% Predicate to solve the problem
solve(Node, Solution) :-
    % Perform depth-first search starting from the initial node
    dfs([], Node, Solution).

% Depth-first search algorithm
dfs(Path, Node, [Node|Path]) :-
    goal(Node).

dfs(Path, Node, Sol) :-
    s(Node, Node1),
    \+ mem(Node1, Path), % Use \+/1 for negation
    dfs([Node|Path], Node1, Sol).
