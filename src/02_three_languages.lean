import system.io
open io

/-

One of the good things about Lean is that you can see it as three different languages.
While all the languages are actually the same, this purely artificial distinction is 
quite helpful for learners.

The next function is a typical function-programming style hello world using monads. 
If one were to write a similar hello world in ML or Haskell, the solution would be 
quite similar.

Run this function from within the main repo folder:

lean --run src/02_three_languages.lean 1 

-/

def main : io unit := do 
    args <- cmdline_args,
    io.print_ln ("hello" ++ (option.get_or_else (list.nth args 0) "a")),
    io.print_ln "world"

/-

plus_one is a pure function that adds one to its input.

Both main and plus_one belong to the first language: the language where you define programs
that execute.
 
 -/

def plus_one : nat -> nat
| n := 1 + n

/- Lean provides some helpers to eval and typecheck these expressions:  -/

#check 1
#reduce 1 + 1
#check tt
/- tt is the computable version of bool  -/


/-

The second language is that of proofs. Everything that starts with theorem,
lemma, example and axiom belongs to this language. You write proofs using tactics.

Due to propositions as types, this is actually the same language as the first (you could
achieve the same using def), but I believe this view of Lean is useful for practicioners.

-/


axiom easy_mode : 0 = 1

example : 1 + 1 = 1 + 0 :=
begin
    rw easy_mode,
end

#check true
/- true is the version of Prop that represents truth in the second language -/

/-

The third language is that in which you define new tactics. This language operates on
the meta-structure of programs, like a hygienic macro. This third language is the most 
different from the first two, and it is not the focus of this tutorial.

Everything that has meta belongs to this language.

-/

open tactic

meta def my_repeat (t : tactic unit) : tactic unit :=
do
    repeat t