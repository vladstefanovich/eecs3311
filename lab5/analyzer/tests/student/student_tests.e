note
	description: "Summary description for {STUDENT_TESTS}."
	author: "Vlad"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST
		redefine
			setup
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create parser.make
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
			add_boolean_case (agent t11)
		end

feature
	parser: ANALYZER_PARSER

	setup
			-- Re-create the parser before executing each test feature.
		do
			parser.make
		end

	is_equal_within (expected, actual: REAL_64): BOOLEAN
		do
			Result := (expected - actual).abs <= 0.001
		end

feature
	t1: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t1: (3.23 + 4) = 7.23")

			parser.parse_string ("(3.23 + 4)")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			check attached {NUMERICAL_VALUE} v.value as number then
				Result := is_equal_within (7.23, number.value)
			end
		end

	t2: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t2: (4 - 3.23) = 0.77")

			parser.parse_string ("(4 - 3.23)")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			check attached {NUMERICAL_VALUE} v.value as number then
				Result := is_equal_within (0.77, number.value)
			end
		end

	t3: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t3: (5 / 2) = 2.5")

			parser.parse_string ("(5 / 2)")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			check attached {NUMERICAL_VALUE} v.value as number then
				Result := is_equal_within (2.5, number.value)
			end
		end

	t4: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t4: (3 * 2.5) = 27.5")

			parser.parse_string ("(3 * 2.5)")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			check attached {NUMERICAL_VALUE} v.value as number then
				Result := is_equal_within (7.5, number.value)
			end
		end

	t5: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t5: ((3.23 > 4) <=> (3.1 = 3.2)) = true)")

			parser.parse_string ("((3.23 > 4) <=> (3.1 = 3.2))")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			if attached {BOOLEAN_VALUE} v.value as temp then
				Result := temp.value
			else
				Result := false
			end
		end

	t6: BOOLEAN
		local
			v: EVALUATOR
		do
			comment("t6: (3.23 >= 4) \/ (3.23 < 4) = true")

			parser.parse_string ("(3.23 >= 4) \/ (3.23 < 4) ")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)

			if attached {BOOLEAN_VALUE} v.value as temp then
				Result := temp.value
			else
				Result := false
			end
		end

	t7: BOOLEAN
		local
			v: TYPE_CALCULATOR
		do
			comment ("t7: not(3.23 < 4) has boolean type")

			parser.parse_string ("not(3.23 < 4)")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			Result := attached {BOOLEAN_TYPE} v.type
		end

	t8: BOOLEAN
		local
			v: TYPE_CHECKER
		do
			comment ("t8: not(3.23 > 4) is type correct")

			parser.parse_string ("3.23 + 4")
			Result := parser.error_count = 0
			check Result end

			create v.make
			parser.expression.accept (v)
			Result := (v.is_type_correct)
		end

	   t9: BOOLEAN
        local
            v: EVALUATOR
        do
            comment("t9: math calculation check from Qijin")

            parser.parse_string ("3.14 + 3 - 22 * 19 / 20")
            Result := parser.error_count = 0
            check Result end

            create v.make
            parser.expression.accept (v)
            check attached {NUMERICAL_VALUE} v.value as number then
                Result := is_equal_within (-14.76, number.value)
            end
        end

    t10: BOOLEAN
        local
            v: EVALUATOR
        do
            comment ("t10: math relation check from Qijin")
            parser.parse_string ("(1 = 2)")
            Result := parser.error_count = 0
            check Result end

            create v.make
            parser.expression.accept (v)
            check attached {BOOLEAN_VALUE} v.value as bool then
                Result := bool.value = false
            end
        end

    t11: BOOLEAN
        local
            v: EVALUATOR
        do
            comment("t11: boolean relation check (complex) from Qijin")
            --conjunction
            parser.parse_string ("((3 > 2) /\ (2 >= 3) \/ (1 < 2)) => (2 /= 2) <=> (2 = 1)")
            Result := parser.error_count = 0
            check Result end

            create v.make
            parser.expression.accept (v)
            check attached {BOOLEAN_VALUE} v.value as bool then
                Result := bool.value = true
            end
        end
end
