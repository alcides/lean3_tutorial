/-

In this file we will address how to deal with some examples from logic, namely and and or.

-/

/- Ignore this for now. But all imports are on the top of the file. -/
-- import tactic.suggest
/- Uncomment after reading the last note. -/



/- Prove that p ∧ q → p. It should be pretty straight-forward -/

theorem p_and_q_implies_p (p q:Prop):  
    p ∧ q → p :=
begin
    intro proof_of_p_and_q,
    exact proof_of_p_and_q.left, -- how did we know about this?
end

/-

If you delete "left" and ask for the autocomplete (cmd+space), you will not find left.
So how did we know that it was the solution?

If you cmd+click on the ∧ symbol, you go to its definition and you can discover that it is
a structure (similar to a struct in C or records in Haskell). You can see that it is made of
two fields: left and right. In this case, we use the one that is most useful for our proof.

-/

/- Prove that p → p ∨ q -/

theorem p_implies_p_or_q (p q:Prop) : 
    p → p ∨ q := 
begin
    intro proof_of_p,
    left,
    exact proof_of_p,
end

/-
While there are other options, here we use the left (as opposed to the right) tactic.
These two tactics can be used to focus on the right or left side or an ∨-goal. We only
need to prove one of the sides.
-/


theorem q_implies_p_or_q_or_r (p q r :Prop) : 
    q → (p ∨ q) ∨ r := 
begin
    sorry, -- it is another exercice.
end


theorem p_implies_p_or_not_p (p:Prop) : p → p ∨ (¬ p) :=
begin
    sorry, -- it is yet another exercice.
end

/-
    For this last theorem, the structure will be very similar to p_implies_p_or_q. In
    fact, too similar! Instead of copying the proof, you should use the existing theorems
    and lemmas. Tip: despite not being in the shown context, every theorem and lemma can be
    used in the context of proofs.

-/



/- This next example is interesting, because we cannot go left or right. We have
to go both ways.

That can be done using induction on the structure of or. If calling it an induction bothers
you, you can replace "induction" with "cases", which works in the same way.

 -/

example (n:ℕ) : n = 3 ∨ n = 4 → n = 4 ∨ n = 3 :=
begin
    intros or_3_4,
    induction or_3_4,
    {
        right,
        exact or_3_4,
    },
    {
        left,
        exact or_3_4,
    }
end


/-

My main complaints writing proofs was that I had to dive into the source code of
lean standard library looking for lemmas that would solve my problem, without knowing its name.

This example should be trivial to solve, if we have a theorem that shows that ∨ is commutative.

Let's use the "library_search" tactic, imported from "tactic.suggest" on the top of this file,
which you need to uncomment. Notice that it solves the goal, but has a blue wavy underline under 
it. Library_search is useful when writing proofs, but does not serve as a proof that others can 
read. Visual Studio Code shows a shortcut on the right to replace library_search with the found
lemma. The code shown below is the found tactic. Feel free to replace it and try library_search.


Note: library_search does not come with the lean standard library, and does not work on the webbrowser.
This tactic comes with the mathlib library, which you can install following the instructions on the Readme.

-/

example (n:ℕ) : n = 3 ∨ n = 4 → n = 4 ∨ n = 3 :=
begin
    exact or.swap,
end