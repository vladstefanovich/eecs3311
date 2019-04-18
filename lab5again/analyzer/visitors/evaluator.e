note
	description: "Summary description for {EVALUATOR}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	EVALUATOR

inherit
	VISITOR

create
	make

feature -- Status
	value: EXPRESSION_VALUE

feature -- Constructor
	make
		do
			create {NIL} value
		end

feature {NONE} -- Helper Queries

	is_equal_within (expected, actual: REAL_64): BOOLEAN
			-- Is `expected' equal to `actual' within 0.001 tolerance?
		do
			Result := (expected - actual).abs <= 0.001
		end

feature -- To Do: Implement Commands for visiting composite structure
	visit_binary_expression (b: BINARY_EXPRESSION; op: STRING)
			local
				eval_left, eval_right: EVALUATOR
			do
				create eval_left.make
				create eval_right.make
				b.left.accept (eval_left)
				b.right.accept (eval_right)

				if op ~ "+" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {NUMERICAL_VALUE}.make (left.value + right.value)
					end
				elseif op ~ "-" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {NUMERICAL_VALUE}.make (left.value - right.value)
					end
				elseif op ~ "*" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {NUMERICAL_VALUE}.make (left.value * right.value)
					end
				elseif op ~ "/" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						if right.value = 0 then
							value := create {NIL}.default_create
						else
							value := create {NUMERICAL_VALUE}.make (left.value / right.value)
						end
					end
				elseif op ~ "=" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (is_equal_within(left.value, right.value))
					end
				elseif op ~ "/=" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (not(is_equal_within(left.value, right.value)))
					end
				elseif op ~ ">" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value > right.value)
					end
				elseif op ~ ">=" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value >= right.value)
					end
				elseif op ~ "<" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value < right.value)
					end
				elseif op ~ "<=" then
					if attached {NUMERICAL_VALUE} eval_left.value as left and attached {NUMERICAL_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value <= right.value)
					end
				elseif op ~ "/\" then
					if attached {BOOLEAN_VALUE} eval_left.value as left and attached {BOOLEAN_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value and right.value)
					end
				elseif op ~ "\/" then
					if attached {BOOLEAN_VALUE} eval_left.value as left and attached {BOOLEAN_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value or right.value)
					end
				elseif op ~ "=>" then
					if attached {BOOLEAN_VALUE} eval_left.value as left and attached {BOOLEAN_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make (left.value implies right.value)
					end
				elseif op ~ "<=>" then
					if attached {BOOLEAN_VALUE} eval_left.value as left and attached {BOOLEAN_VALUE} eval_right.value as right then
						value := create {BOOLEAN_VALUE}.make ((left.value implies right.value) and (right.value implies left.value))
					end
				end
			end

	visit_unary_expression (u: UNARY_EXPRESSION; op: STRING)
			local
				eval: EVALUATOR
			do
				create eval.make
				u.expr.accept (eval)

				if op ~ "not" then
					if attached {BOOLEAN_VALUE} eval.value as exp then
						value := create {BOOLEAN_VALUE}.make (not(exp.value))
					end
				end
			end

feature -- Commands for visiting composite structure

	visit_value_constant(c: VALUE_CONSTANT)
		do
			value := create {NUMERICAL_VALUE}.make (c.value)
		end

end
