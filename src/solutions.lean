

/-
01_first.lean
-/

theorem my_second_theorem : 
        ∀ p q : Prop, p → q → p 
    :=
begin
  intros p q proof_of_p proof_of_q,
  exact proof_of_p,
end

/-
03_haskell.lean

theorem map_id_is_the_same (a:Type) (xs:L a) : 
    map id xs = xs :=
begin
    induction xs,
    {
        rw map,
    },
    {
        rw map,
        rw id,
        rw xs_ih,
    }
end

-/


/-
04_fol.lean
-/

/- Given! -/

theorem p_implies_p_or_q (p q:Prop) : 
    p → p ∨ q := 
begin
    intro proof_of_p,
    left,
    exact proof_of_p,
end

/- Actual Solutions -/

theorem q_implies_p_or_q_or_r (p q r :Prop) : 
    q → (p ∨ q) ∨ r := 
begin
    intro proof_of_q,
    left,
    right,
    exact proof_of_q,
end


theorem p_implies_p_or_not_p (p:Prop) : p → p ∨ (¬ p) :=
begin
    exact p_implies_p_or_q _ _, 
    -- alternative, if you want to know what lean filled the _ with.
    -- exact p_implies_p_or_q p (¬ p)
end