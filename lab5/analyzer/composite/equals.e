note
	description: "Summary description for {EQUALS}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALS

inherit
	BINARY_EXPRESSION

create
	make

feature -- Command for accepting a visitor
	accept (v: VISITOR)
		do
			-- To Do
			v.visit_equals (Current)
		end

end
