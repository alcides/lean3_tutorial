/-
How to learn LEAN by reading code:

Place your cursor before and after each line within the begin-end block.

The goal is prove the goal (after :) from whatever we have in the arguments of the function/theorem/lemma/example

-/

theorem my_first_theorem : 
    ∀ p, p → p :=
begin
    intro p,
    intro proof_of_p,
    exact proof_of_p,
end

/-
A theorem is made of a name, arguments, goal and proof. 

The first example has no arguments and has type "∀ p, p → p" and this is what we want to prove.

In each line we make progress either on the context (what comes before the turnstile ⊢) or the goal (after it).
Each line has a tactic and arguments. (It is similar to haskell's do-notation for monads, if you known what it is.)

The first tactic here is intro, which pushes the left-most ∀ or → into the context with the given name and out of the goal.
Another name for this tactic is "assume", which might be more familiar for those with a math background.

The second tactic is exact, which provides exactly a proof of the goal (similarly to monad's return).

-/


theorem my_first_theorem_2 : 
    ∀ p, p → p :=
begin
    intro p,
    exact id,
end

/-
This second version of the same theorem uses an existing lemma for this purpose.

This theorem was defined in the first "language" of lean: the implementation language. 
Theorems are implemented as functions and they are exactly the same thing. If you have a 
moment, please see Phil Wadler's talk on Propositions as Types (https://www.youtube.com/watch?v=IOiZatlZtGU&t=11s).

def id {α : Sort u} (a : α) : α := a
-/


theorem my_first_theorem_3 (p:Prop):
    p → p :=
begin
    exact id,
end

/-
This third version moves the universial quantifier from the goal to the context directly in the definition (as opposed to using intro).
This is akin to haskell's function definition using lambda or using arguments.

f a = a + 1
f = \ a -> a + 1
-/



theorem my_first_theorem_4 (p:Prop) (proof_of_p:p):
    p :=
begin
    exact proof_of_p,
end

/-
This fourth version moves both the universial quantifier and the p into the context in the definition. This is the more popular style.
-/


lemma my_first_theorem_5 (p:Prop):
    p → p :=
begin
    exact id,
end

/-

Lemmas and Theorems are the same thing for the language. You can choose which one serves your purpose.

-/

example (p:Prop):
    p → p :=
begin
    exact id,
end

/-

Examples are anonymous lemmas or theorems. We use when there is no point in giving it a name.

-/


theorem  my_first_theorem_6 (p:Prop) : p → p := by exact id

/-

This is the most common style for proofs. I don't like it, so we will always use begin-end blocks.

-/


theorem my_first_theorem_7 : 
    ∀ p:Prop, p → p :=
begin
    intros p proof_of_p,
    exact proof_of_p,
end

/-

This seventh version uses intros p proof_of_p, instead of two intro. You can use this
shortcut to introduce as many variables into context as you want.

-/




/-
    Exercice time! Now it's your turn to apply what you did:
-/

theorem my_second_theorem : 
    ∀ p q : Prop, p → q → p :=
begin
  sorry, -- now it's your turn to do some proving.
end