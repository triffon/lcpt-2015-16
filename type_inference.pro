/* infers_type(Gamma, Term, Type).
   Gamma = [ [Var,Type], [Var,Type], ... ]
   Term = Var | app(Term1,Term2) | lambda(Var,Term)
   Type = Alpha | arrow(Type1,Type2)
*/

:- set_prolog_flag(occurs_check, true).

infers_type(Gamma, Var, Type) :- member([Var, Type], Gamma).
infers_type(Gamma, app(M, N), Type) :-
        infers_type(Gamma, M, arrow(Rho, Type)),
        infers_type(Gamma, N, Rho).
infers_type(Gamma, lambda(Var, Term), Type) :-
        Type = arrow(Rho,Sigma),
        infers_type([[Var,Rho]|Gamma], Term, Sigma).
