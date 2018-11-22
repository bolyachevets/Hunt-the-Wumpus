% helper to decrement arrow count
decr(X,NX) :-
    NX is (X-1).

sample_without_replacement(Range, N, Sample) :-
    random_permutation(Range, Permutation),
    length(Sample, N),
    append(Sample, _, Permutation).
