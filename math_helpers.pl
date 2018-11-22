% helper to decrement arrow count
decr(X,NX) :-
    NX is (X-1).

sample_without_replacement(Range, N, Sample) :-
    random_permutation(Range, Permutation),
    length(Sample, N),
    append(Sample, _, Permutation).

index_of([Elem|_], Elem, 1):- !.
index_of([_|Tail], Elem, Index):-
    index_of(Tail, Elem, Index1),
    !,
    Index is Index1 + 1.