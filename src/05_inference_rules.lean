/-

One of the reference works for proving theorems about programming languages is
Phil Wadler's Programming Language Foundations in Agda.

Inference rules are frequently used in the programming languages community to express
several aspects of programming like type checking and semantics, among others.


By defining our rules as axioms, we are building a logical framework on top of 
which we will prove theorems.

-/


/-

This micro-language receives strings from the user, has an escape operator
and a consume function, that should receive only escaped values. Think of this
language as a safe alternative to my_sql_escape in PHP that prevents SQL
injection.
 -/
inductive Expr : Type
| from_user : string → Expr
| escape : Expr → Expr
| consume : Expr → Expr
| concat : Expr → Expr → Expr

open Expr

/- This axiom will allow us to express whether a given expression is safe or not. -/
axiom is_safe : Expr → Prop


/-

Below are our inference rules that define our "type system".
Notice how we are abusing lean's comments to fake the horizontal line.

 -/

axiom from_user_unsafe {s}:

------------------------
¬ is_safe (from_user s)


axiom escape_makes_it_safe {e}:

-------------------------
is_safe (escape e)


axiom consume_requires_safe {e}:
is_safe e ↔
---------------------------
is_safe (consume e)


axiom concat_requires_both_safe {e1 e2}:
is_safe e1 ∧ is_safe e2 ↔
---------------------------
is_safe (concat e1 e2)





/-

Let us prove that a simple program is valid.

Apply works by applying a function from the goal towards the context. In Haskell it is similar to:

bToC :: b -> c

f :: a -> b -> c
f x = bToC

In lean, we would write "apply bToC" to bring the goal of writing f from c to b. The last step of
the proof is done, we just have to get to point b.


-/

example :
    is_safe (consume (concat (escape (from_user "a")) (escape (from_user "b")))) :=
begin
    apply consume_requires_safe.mp,
    apply concat_requires_both_safe.mp,
    {
        split,
        {
            apply escape_makes_it_safe,
        }, {
            apply escape_makes_it_safe,
        }
    }
end


def has_any_escape : Expr → Prop
| (from_user s) := false
| (escape e) := true
| (consume e) := has_any_escape e
| (concat e1 e2) := has_any_escape e1 ∨ has_any_escape e2


/-

The is_safe was written in the second language.
has_any_escape was written in the first language, but could as well be written in the second.

Here is the proof that any program that is safe, has at least one escape.

-/

theorem if_is_safe_has_some_escape {e} :
    is_safe e → has_any_escape e :=
begin
    intro ise,
    induction e,
    {
        -- from_user
        have useful_proof := from_user_unsafe ise,
        rw has_any_escape,
        exact useful_proof,
    },
    {
        -- escape
        rw has_any_escape,
        cc,
    },
    {
        -- consume
        rw has_any_escape,
        apply e_ih,
        apply consume_requires_safe.mpr ise,
    },
    {
        -- concat
        rw has_any_escape,
        left,
        apply e_ih_a,
        have helper := concat_requires_both_safe.mpr ise,
        have helper_ex := helper.left,
        exact helper_ex,
    }
end