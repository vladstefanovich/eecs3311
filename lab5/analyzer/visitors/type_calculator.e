note
	description: "Summary description for {TYPE_CALCULATOR}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CALCULATOR

inherit
	VISITOR

create
	make

feature -- Status
	type: EXPRESSION_TYPE

feature -- Constructor
	make
		do
			create {UNKNOWN_TYPE} type
		end

feature -- To Do: Implement Commands for visiting composite structure

	visit_unary_expression(u: UNARY_EXPRESSION; op: STRING)
		local
			eval: EVALUATOR
			type_correct: TYPE_CHECKER
		do
			create eval.make
			u.expr.accept (eval)

			create type_correct.make
			u.accept (type_correct)

			if op ~ "not" and type_correct.is_type_correct then
				create {BOOLEAN_TYPE} type
			end
		end

	visit_binary_expression(b: BINARY_EXPRESSION; op: STRING)
		local
			eval_left, eval_right: EVALUATOR
			type_correct: TYPE_CHECKER
		do
			create eval_left.make
			create eval_right.make
			b.left.accept (eval_left)
			b.right.accept (eval_right)

			create type_correct.make
			b.accept (type_correct)

			if (op ~ "+" or op ~ "-" or op ~ "*" or op ~ "/") and type_correct.is_type_correct  then
				create {NUMERICAL_TYPE} type
			elseif (op ~ "=" or op ~ "/=" or op ~ ">" or op ~ ">=" or op ~ "<" or op ~ "<=" or op ~ "/\" or op ~ "\/" or op ~ "=>" or op ~ "<=>") and type_correct.is_type_correct then
				create {BOOLEAN_TYPE} type
			end
		end

feature -- Commands for visiting composite structure

	visit_value_constant(c: VALUE_CONSTANT)
		local
			type_correct: TYPE_CHECKER
		do
			create type_correct.make
			c.accept (type_correct)

			if type_correct.is_type_correct then
				create {NUMERICAL_TYPE} type
			end
		end

	visit_addition (e: ADDITION)
		do
			visit_binary_expression (e, "+")
		end

	visit_subtraction (e: SUBTRACTION)
		do
			visit_binary_expression (e, "-")
		end

	visit_multiplication (e: MULTIPLICATION)
		do
			visit_binary_expression (e, "*")
		end

	visit_division (e: DIVISION)
		do
			visit_binary_expression (e, "/")
		end

	visit_equals (e: EQUALS)
		do
			visit_binary_expression (e, "=")
		end

	visit_not_equals (e: NOT_EQUALS)
		do
			visit_binary_expression (e, "/=")
		end

	visit_greater_than (e: GREATER_THAN)
		do
			visit_binary_expression (e, ">")
		end

	visit_greater_than_or_equals (e: GREATER_THAN_OR_EQUALS)
		do
			visit_binary_expression (e, ">=")
		end

	visit_less_than (e: LESS_THAN)
		do
			visit_binary_expression (e, "<")
		end

	visit_less_than_or_equals (e: LESS_THAN_OR_EQUALS)
		do
			visit_binary_expression (e, "<=")
		end

	visit_conjunction (e: CONJUNCTION)
		do
			visit_binary_expression (e, "/\")
		end

	visit_disjunction (e: DISJUNCTION)
		do
			visit_binary_expression (e, "\/")
		end

	visit_implication (e: IMPLICATION)
		do
			visit_binary_expression (e, "=>")
		end

	visit_iff (e: IFF)
		do
			visit_binary_expression (e, "<=>")
		end

	visit_negation (e: NEGATION)
		do
			visit_unary_expression (e, "not")
		end

end
