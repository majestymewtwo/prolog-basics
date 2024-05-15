
solution([]).
solution([X/Y | Others]) :-
    solution(Others),
    mem(Y, [1,2,3,4,5,6,7,8]),
    noattack(X/Y, Others).

mem(X, [X | _ ]).
mem(X, [_ | T]) :- mem(X, T).

noattack(_, []).
noattack(X/Y, [X1/Y1 | Others]):-
    Y =\= Y1,
    X =\= X1,
    abs(Y1 - Y) =\= abs(X1 - X),
    noattack(X/Y, Others).

template([1/_ , 2/_ , 3/_ , 4/_ , 5/_ , 6/_ , 7/_ , 8/_ ]).

solve(Solution) :-
    template(Solution),
    solution(Solution).