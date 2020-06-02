/-

In a undergraduate class I have taught the past years, it was frequent to ask students
to prove some properties about their programs.

Here we follow the exercices students have been typically asked to do in pen and paper.

-/


/-

This is how you inductively define new types. 

The haskell version:

data List a = Empty
            | Cons a (List a)


Note: Lean provides a convient list structure with a few lemmas available. You should
use the default ones as much as possible, as they will save you time and trouble.

-/

inductive L (a:Type) : Type
| empty : L
| cons : a → L → L

/-

If you want to refer to the empty constructor, you have to use "L.empty". 
While this allows you to have multiple constructors with the same name in
different types, it clutters the code.

To overcome it, we bring everything within L to the outer scope with:
-/

open L



/-

length :: [a] -> nat
length [] = 0
length (x:xs) = 1 + length xs

-/

def length {a:Type} : L a → nat
| empty := 0
| (cons head tail) := 1 + length tail


/-
map :: (a → b) → [a] → [b]
map _ [] = []
map f (x:xs) = f x : map f xs
-/

def map {a:Type} {b:Type} : (a → b) → L a  → L b
| _ empty := empty
| f (cons head tail) := cons (f head) (map f tail)



/-

Now that we have defined the computable part, let us move into the second language 
to prove some properties.

In this first example, we will show a particular example, not really a property. As such,
we will use example instead of lemma or theorem.

-/

example : 
        length (map id (cons 1 (cons 2 empty))) = 2 
    :=
begin
    rewrite map,
    rw map,
    rw map,
    rw length,
    rw length,
    rw length,
end
/-

rw stands for rewrite, a new tactic that replaces the ocurrent of that function, using its definition.
This is a very useful tactic. 

The proof is very repetitive — nobody writes code/proofs like this. Let's see how to improve it in this level.

-/


/-
Next goal: prove that the length of the map of a list is equal to that of the original list.
-/

theorem length_map_is_the_same (a b:Type) (f:a→b) (xs:L a) : 
    length (map f xs) = length xs :=
begin
    induction xs,
    {
        -- Base case: empty
        rw length,
        rw map,
        rw length,
    },
    {
        -- Recursive case: cons
        rw map,
        rw length,
        rw length,
        rw xs_ih,
    }
end

/-

This is our first proof by induction on the structure of the list xs.

If you try to rw map or length before doing the induction, it will yield an error. If a function is
defined using equations, rewrite is only possible if it is clear which of the equations to use. For that
we need to rewrite empty or rewrite cons. By using induction, we can rewrite is knowing its structure.

The induction tactic leaves two goals to be solved instead of the original one. Now we need to prove both,
but they are hopefully easier. Despite not being necessary, we organize both goals using curly braces. To
each goal its block. (begin-end also work, but let us reserve those for the outer scope only. Despite having
editor support, it is considered polite to comment what each sub-goal refers to.

Typically in the recursive/inductive step, we are looking to advance one side of the equality to contain one
side of the inductive hypothisis. The default name in this case is (xs_ih). Always look at the context on the
side window and look for it.

-/


@[simp] /- Please ignore this line for now. -/
theorem map_id_is_the_same (a:Type) (xs:L a) : 
    map id xs = xs :=
begin
    sorry, -- it is your turn again.
end


/-

Let us address the weird @[simp] address before the last theorem. Have you noticed how
you have never had to proe that 1+1 = 2 or any of those basic steps. Most tactics try
to simplify the result automatically, but you can do it manually using the "simp" tactic.

The annotation in the previous theorem is how the user can indicate that whenver Lean tries
to simplify a proposition, it can use that theorem automatically. It is how the Lean
standard library was written.

-/

example : 
    length (map id (cons 1 (cons 2 empty))) == 1 + 1 :=
begin
    simp,
    repeat {
        rw length,
    },
end

/-

The other new tactic in this example is the repeat tactic, that tries to repeat the inside tactics
as many times as possible until it fails, even if it fails at the first try.

This is how you can avoid the boilerplate in the first example in this file.

-/