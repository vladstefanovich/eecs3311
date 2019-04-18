note
	description: "Summary description for {SORTED_MAP_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SORTED_MAP_CURSOR [K -> COMPARABLE, V -> ANY]

inherit
	ITERATION_CURSOR [TUPLE [K, V]]

create
	make

feature -- Constructor
	make (a: ARRAY[TUPLE[K,V]])
		-- Initialize cursor
	do
		arr := a

		cursor_pos := a.lower
	end

feature -- Access

	item: TUPLE [key: K; value: V]
			-- Item at current cursor position.
		do
			Result := arr[cursor_pos]
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := (cursor_pos > arr.count)
		end

feature -- Cursor movement

	forth
			-- Move cursor to next position.
		do
			cursor_pos := cursor_pos + 1
		end

feature	{NONE} -- Underlying arrays.
	arr: ARRAY[TUPLE[K,V]]

	cursor_pos: INTEGER

end
