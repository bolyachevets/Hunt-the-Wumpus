% helper to decrement arrow count
decr(X,NX) :-
    NX is (X-1).

% pseudo random number for Wumpus, 'using' LCG algorithm
random_location(X, NX) :-
   NX is (mod(X*37, 20) + 1).
