note
	description: "Summary description for {TYPE_CHECKER}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit
	VISITOR

create
	make

feature -- Status
	is_type_correct: BOOLEAN

feature -- Constructor
	make
		do
			is_type_correct := false
		end

feature -- To Do: Implement Commands for visiting composite structure

	visit_value_constant(c: VALUE_CONSTANT)
		do
			is_type_correct := attached {REAL_64} c.value
		end

	visit_unary_expression(u: UNARY_EXPRESSION; op: STRING)
		local
			eval: EVALUATOR
		do
			create eval.make
			u.expr.accept (eval)

			if op ~ "not" then
				is_type_correct := attached {BOOLEAN_VALUE} eval.value
			end
		end

	visit_binary_expression(b: BINARY_EXPRESSION; op: STRING)
		local
			eval_left, eval_right: EVALUATOR
		do
			create eval_left.make
			create eval_right.make
			b.left.accept (eval_left)
			b.right.accept (eval_right)

			if op ~ "+" or op ~ "-" or op ~ "*" or op ~ "/" or op ~ "=" or op ~ "/=" or op ~ ">" or op ~ ">=" or op ~ "<" or op ~ "<=" then
				is_type_correct := attached {NUMERICAL_VALUE} eval_left.value and attached {NUMERICAL_VALUE} eval_right.value
			elseif op ~ "/\" or op ~ "\/" or op ~ "=>" or op ~ "<=>" then
				is_type_correct := attached {BOOLEAN_VALUE} eval_left.value and attached {BOOLEAN_VALUE} eval_right.value
			end
		end

end
