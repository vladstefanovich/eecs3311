note
	description: "Summary description for {CONJUNCTION}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	CONJUNCTION

inherit
	BINARY_EXPRESSION

create
	make

feature -- Command for accepting a visitor
	accept (v: VISITOR)
		do
			-- To Do
			v.visit_conjunction (Current)
		end

end
