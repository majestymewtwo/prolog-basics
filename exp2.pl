marks(albert, 78).
marks(alice, 89).
marks(bob, 68).
marks(betsy, 48).
marks(mark, 48).

failed(X) :- marks(X, Mark), Mark < 50.
