/* infers_type(Gamma, Term, Type).
   Gamma = [ [Var,Type], [Var,Type], ... ]
   Term = Var | app(Term1,Term2) | lambda(Var,Term)
   Type = Alpha | arrow(Type1,Type2)
*/

ti(arrow(alpha,alpha)).
tk(arrow(alpha,arrow(beta,alpha))).
tc0(arrow(alpha,arrow(beta,beta))).
tc1(arrow(arrow(alpha,beta),arrow(alpha,beta))).
tcn(arrow(arrow(alpha,alpha),arrow(alpha,alpha))).
tp(arrow(alpha,arrow(arrow(alpha,beta),beta))).
tp3(arrow(alpha,
          arrow(
                arrow(alpha,beta),
                arrow(
                      arrow(beta,gamma),
                      gamma)))).
ts(arrow(
         arrow(gamma,arrow(ni,delta)),
         arrow(
               arrow(gamma,ni),
               arrow(gamma,delta)))).
tu(arrow(arrow(alpha,alpha),alpha)).

/* infers_type(+Gamma, -Term, +Type). */

infers_type(Gamma, Var, Type) :- member([Var,Type],Gamma).
infers_type(Gamma, lambda(Var,Term), arrow(Rho, Sigma)) :-
        infers_type([[Var,Rho]|Gamma], Term, Sigma).
infers_type(Gamma, app(Var, Arg), Sigma) :-
        member([Var,arrow(Rho, Sigma)], Gamma),
        infers_type(Gamma, Arg, Rho).