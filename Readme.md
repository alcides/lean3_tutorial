# Lean tutorial

Alcides Fonseca

http://alcidesfonseca.com/



## What is LEAN?

Lean is a programming language + compiler that also works as a interactive theorem prover. Lean is being developed by Microsoft and the project is led by Leonardo de Moura of Z3's fame.

We will be covering Lean 3, the latest stable version. Lean 4 is being developed without external contributions at this time.


# Important:

This file was written for a live tutorial. For the written down version, see the files inside the src folder, by order.



## This is an interactive tutorial.

Follow along at home at: 

https://leanprover-community.github.io/lean-web-editor/


You can install lean (brew install lean) and use [emacs mode](https://github.com/leanprover/lean-mode) or vscode, through its extension marketplace.


## My first proof

```lean
theorem my_first_theorem : ∀ p, p → p :=
begin
    sorry
end
```

* You can write "∀" with \forall<TAB> and "→" with \r<TAB>. "forall" and "->" also works, but no one uses them.
* This theorem typechecks, but has a warning: `declaration 'my_first_theorem' uses sorry`.
* Let us write a proof that LEAN can check for us. Let's use the "Lean Goal" window to find what we have and what we want.


### Tactics so far

- intro
- intros
- revert
- exact

###  My second proof

```lean
theorem my_second_theorem : ∀ p q :Prop, p → q → p  :=
begin
    sorry, -- it's your turn :(
end
```


## Let us go back to PP

```lean
inductive L (a:Type) : Type
| empty : L
| cons : a → L → L

open L

def length {a:Type} : L a → nat
| empty := 0
| (cons head tail) := 1 + length tail

def map {a:Type} {b:Type} : (a → b) → L a  → L b
| _ empty := empty
| f (cons head tail) := cons (f head) (map f tail)


theorem length_map_is_the_same : ∀ a:Type, ∀ b:Type, ∀ f:(a→b), ∀ xs, length (map f xs) = length xs :=
begin
  sorry,
end

theorem map_id_is_the_same : ∀ a:Type, ∀ (xs:L a), map id xs = xs :=
begin
    sorry, -- it's your turn :(
end
```

### Tactics so far

- intro n,
- intros n m,
- revert n m,
- exact p,
- induction var,
- rw fun
- repeat
- simp and `@[simp]`


## Let us go back even further


```lean
theorem p_and_q_implies_p (p q:Prop):  p ∧ q → p :=
begin
    sorry,
end

theorem p_implies_p_or_q (p q:Prop) : p → p ∨ q := 
begin
    sorry,
end

theorem p_implies_p_or_not_p (p:Prop) : p → p ∨ (¬ p) :=
begin
    sorry, -- your turn! Surprise me!
end

example (n:ℕ) : n = 3 ∨ n = 4 → n = 4 ∨ n = 3 :=
begin
    sorry, -- your turn again! You are almost a proof master!
end
```

### Tactics so far

- intro n,
- intros n m,
- revert n m,
- exact p,
- induction var,
- rw fun
- repeat
- simp and `@[simp]`
- left, right
- cases
- rw ←fun


### Lemmas so far:
* and.elim_left




## Understand the two languages

```lean
import system.io
open io

def main : io unit := do 
    args <- cmdline_args,
    io.print_ln ("hello" ++ (option.get_or_else (list.nth args 0) "a")),
    io.print_ln "world"

def mais_um : nat -> nat
| n := 1 + n


theorem difficult_theorem : mais_um 0 = 0 :=
begin
    sorry
end
```


## Use library_search

```bash
leanpkg add https://github.com/leanprover/mathlib
leanpkg build
```

```lean
import tactic.suggest
```


## I want to learn more:

https://leanprover.github.io/

https://leanprover.zulipchat.com <-- I have gotten useful help in a matter of minutes twice in the past!


## What can I use Lean for?

* The same you use agda, coq or idris for.

* Here is an interesting project that converts Rust to Lean for proving properties about Rust programs: [Simple Verification of Rust Programs via Functional Purification](https://kha.github.io/electrolysis/presentation.pdf)