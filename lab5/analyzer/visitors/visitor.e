note
	description: "Summary description for {VISITOR}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR

feature -- To Do: Declare Commands for visiting composite structure

	visit_value_constant(c: VALUE_CONSTANT)
		deferred
		end

	visit_addition(a: ADDITION)
		deferred
		end

	visit_conjunction(c: CONJUNCTION)
		deferred
		end

	visit_disjunction(d: DISJUNCTION)
		deferred
		end

	visit_division(d: DIVISION)
		deferred
		end

	visit_equals(e: EQUALS)
		deferred
		end

	visit_greater_than(g: GREATER_THAN)
		deferred
		end

	visit_greater_than_or_equals(g: GREATER_THAN_OR_EQUALS)
		deferred
		end

	visit_iff(i: IFF)
		deferred
		end

	visit_implication(i: IMPLICATION)
		deferred
		end

	visit_less_than(g: LESS_THAN)
		deferred
		end

	visit_less_than_or_equals(g: LESS_THAN_OR_EQUALS)
		deferred
		end

	visit_multiplication(m: MULTIPLICATION)
		deferred
		end

	visit_negation(n: NEGATION)
		deferred
		end

	visit_not_equals(n: NOT_EQUALS)
		deferred
		end

	visit_subtraction(s: SUBTRACTION)
		deferred
		end

end
