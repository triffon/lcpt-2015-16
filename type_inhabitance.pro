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
tt(arrow(arrow(beta,alpha),
         arrow(
               arrow(alpha,beta),
               beta))).


/* deconstruct_type(-ArgTypes, -ResultType, +Type) */ 
deconstruct_type([], Type, Type) :- atom(Type).
deconstruct_type([Rho|ArgTypes], ResultType, arrow(Rho, Sigma)) :-
        deconstruct_type(ArgTypes, ResultType, Sigma).

/* infers_types(+Gamma, -Terms, +Types) */
infers_types(_, [], []).
infers_types(Gamma, [Term|Terms], [Type|Types]) :-
        infers_type(Gamma, Term, Type),
        infers_types(Gamma, Terms, Types).

/* construct_application(+Function, +Args, -Application) */
construct_application(F, [], F).
construct_application(F, [Arg|Args], Application) :-
        construct_application(app(F, Arg), Args, Application).

/* infers_type(+Gamma, -Term, +Type). */

infers_type(Gamma, Var, Type) :- member([Var,Type],Gamma).
infers_type(Gamma, lambda(Var,Term), arrow(Rho, Sigma)) :-
        infers_type([[Var,Rho]|Gamma], Term, Sigma).
infers_type(Gamma, Application, Sigma) :-
        /*
        member([Var, arrow(Rho1,arrow(Rho2,...,arrow(Rhon,Sigma)))], Gamma),
        infers_type(Gamma, Term1, Rho1),
        ...,
        infers_type(Gamma, Termn, Rhon),
          Application = app(...app(Var, Term1), Term2, ..., Termn)*/
        member([Var, Type], Gamma),
        deconstruct_type(ArgTypes, Sigma, Type),
        infers_types(Gamma, Terms, ArgTypes),
        construct_application(Var, Terms, Application).