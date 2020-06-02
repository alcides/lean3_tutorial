# Lean tutorial

Alcides Fonseca

http://alcidesfonseca.com/



## What is LEAN?

Lean is a programming language + compiler that also works as a interactive theorem prover. Lean is being developed by Microsoft and the project is led by Leonardo de Moura of Z3's fame.

We will be covering Lean 3, the latest stable version. Lean 4 is being developed without external contributions at this time.


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
* Let us write a proof that LEAN can check for us. Let's use the "Lean Goal" window to 





## I want to learn more:

https://leanprover.github.io/

https://leanprover.zulipchat.com <-- I have gotten useful help in a matter of minutes twice in the past!