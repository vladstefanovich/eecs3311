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

	visit_unary_expression(u: UNARY_EXPRESSION; op: STRING)
		deferred
		end

	visit_binary_expression(b: BINARY_EXPRESSION; op: STRING)
		deferred
		end

end
