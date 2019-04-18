note
	description: "[
		{SORTED_BST} is a concrete implementation of sorted tree. It
		inherits all of {SORTED_TREE}'s features and contracts and
		implements its deferred features.
		
		You must implement to specifications/tests
		wherever you see
			-- TO DO --
			check False end
	]"
	author: "JP, JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	SORTED_BST[K -> COMPARABLE, V -> ANY]

inherit
	SORTED_TREE_ADT[K,V]

create
	make_empty

feature{NONE} -- private commands

	extend_node(a_item: TUPLE[key:K; val:V]; a_node: NODE[K,V])
			-- helper method to extend `node' with `a_item'
		do
			-- TO DO --
			--check False end

		if attached a_node as p then
			if p.key < a_item.key then
				if attached p.right as r then
					extend_node (a_item, r)
				else
					p.set_right (a_item)
				end
			else
				if attached p.left as l then
					extend_node (a_item, l)
				else
					p.set_left (a_item)
				end
			end
		end
		end

	remove_node(a_node: NODE[K,V])
			-- helper method to remove `node'
		local

		do
			-- TO DO --
--			check False end

		end

end
