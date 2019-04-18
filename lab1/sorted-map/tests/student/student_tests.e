note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
		end

feature
	t1: BOOLEAN
		local
			u: UTIL[INTEGER]
			left, right: ARRAY[INTEGER]
			concat, expected: ARRAY[INTEGER]
		do
			comment("t1: concat 2 non-emty arrays")
			left := <<15,5,9>>
			right := <<12>>
			concat := u.concatenate(left, right)
			expected := <<15,5,9,12>>
			Result := expected ~ concat
		end

	t2: BOOLEAN
		do
			comment("t2: describe test t2 here")
			Result := False
		end

	t3: BOOLEAN
		do
			comment("t3: describe test t3 here")
			Result := False
		end

	t4: BOOLEAN
		do
			comment("t4: describe test t4 here")
			Result := False
		end
end
