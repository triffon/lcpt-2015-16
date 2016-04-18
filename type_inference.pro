/* infers_type(Gamma, Term, Type).
   Gamma = [ [Var,Type], [Var,Type], ... ]
   Term = Var | app(Term1,Term2) | lambda(Var,Term)
   Type = Alpha | arrow(Type1,Type2)
*/

:- set_prolog_flag(occurs_check, true).

i(lambda(x,x)).
k(lambda(x,lambda(y,x))).
s(lambda(x,lambda(y,lambda(z,app(app(x,z),app(y,z)))))).
c0(lambda(f,lambda(x,x))).
c1(lambda(f,lambda(x,app(f,x)))).
c2(lambda(f,lambda(x,app(f,app(f,x))))).
c3(lambda(f,lambda(x,app(f,app(f,app(f,x)))))).
w(lambda(x,app(x,x))).
omega(app(W,W)) :- w(W).

/* infers_type(?Gamma, +Term, ?Type). */

infers_type(Gamma, Var, Type) :-
        /*        Var \= app(M,N), Var \= lambda(X,M), */
        atom(Var),
        member([Var, Type], Gamma).
infers_type(Gamma, app(M, N), Sigma) :-
        infers_type(Gamma, M, arrow(Rho, Sigma)), /* търси Rho и Sigma, type inference */
        infers_type(Gamma, N, Rho).               /* проверява за Rho, type checking */
infers_type(Gamma, lambda(Var, Term), arrow(Rho,Sigma)) :-
        infers_type([[Var,Rho]|Gamma], Term, Sigma).
