note
	description: "Summary description for {GREATER_THAN}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	GREATER_THAN

inherit
	BINARY_EXPRESSION

create
	make

feature -- Command for accepting a visitor
	accept (v: VISITOR)
		do
			-- To Do
			v.visit_binary_expression (Current, ">")
		end

end
