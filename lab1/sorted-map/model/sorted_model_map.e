note
	description: "Summary description for {SORTED_MODEL_MAP}."
	author: "Vladimir Stefanovich"
	date: "$Date$"
	revision: "$Revision$"

class
	SORTED_MODEL_MAP [K -> COMPARABLE, V -> ANY]

inherit
	SORTED_MAP_ADT[K,V]

create
	make_empty, make_from_array, make_from_sorted_map


feature -- model

	model: FUN[K,V]
			-- abstraction function
		do
			Result := implementation
		end

feature{NONE} -- attributes

	implementation: FUN[K,V]
			-- inefficient but abstract implementation of sorted
		attribute
			create Result.make_empty
		end

feature{NONE} -- constructors

	make_empty
			-- creates a sorted map without any elements
		do
			implementation.make_empty
		end

	make_from_array (array: ARRAY [TUPLE [key: K; val: V]])
			-- creates a sorted map with the elements of the `array'
		do
			implementation.make_from_array(array)
		end

	make_from_sorted_map (map: SORTED_MAP_ADT [K, V])
			-- creates a sorted map from `other'
		do
			make_from_array(map.as_array)
		end

feature -- commands

	put (val: V; key: K) --(key: K; val: V)
			-- puts an element of `key' and `value' into map
			-- behaves like `extend' if `key' does not exist
			-- otherwise behaves like `replace'
			-- NOTE: This method follows the convention of `val'/`key'
		do
			if has(key) then
				replace (key,val)
			else
				extend (key,val)
			end

		end

	extend (key: K; val: V)
			-- inserts an element of `key' and `value' into map
		do
			model.extend ([key,val])
		end

	remove (key: K)
			-- removes an element whose value is `key' from the map
		do
			model.subtract ([key,model.item (key)])
		end

	replace (key: K; val: V)
			-- replaces `value' for a given `key'
		do
			model.override_by ([key,val])
		end

	replace_key (old_key, new_key: K)
			-- replaces `old_key' with `new_key' for an element
		do
		end

	wipe_out
			--makes an existing map empty
		do
		end

feature -- queries

	item alias "[]" (key: K): V assign put
			--returns the value associated with `key'
		do
			Result := model.item (key)
		end

	as_array: ARRAY [TUPLE [key: K; value: V]]
			-- returns an array of tuples sorted by key
		do
			create Result.make_empty
			across sorted_keys.lower |..| sorted_keys.upper as i
				loop
					Result.force ([sorted_keys [i.item], values [i.item]], i.item)
				end
		end

	sorted_keys: ARRAY [K]
			-- returns a sorted array of keys
		local
			ut : UTIL [K]
		do
			Result := ut.merge_sort(model.domain.as_array)
		end

	values: ARRAY [V]
			--returns an array of values sorted by key
		do
			create Result.make_empty
			across sorted_keys.lower |..| sorted_keys.upper as i
				loop
					Result.force (model.item (sorted_keys [i.item]), i.item)
				end
		end

	has (key: K): BOOLEAN
			-- returns whether `key' exists in the map
		do
			Result := model.domain.has (key)
		end

	has_value(val: V): BOOLEAN
			-- returns whether `val' exists in the map
		do
		end

	element (key: K): detachable TUPLE [key: K; val:V]
			-- returns an element of the map (i.e. a tuple [`key', value])
			-- associated with `key'
		do
			Result := [key, model.item (key)]
		end

	count: INTEGER
			--returns number of elements in the map
		do
			Result := model.count
		end

	is_empty: BOOLEAN
			-- returns whether the map is empty
		do
			Result := model.is_empty
		end

	min: TUPLE [key: K; val: V]
			--returns the element with the smallest key in the map
		local
			mi : INTEGER
		do
			mi := sorted_keys.lower
			Result := [sorted_keys[mi], values[mi]]
		end

	max: TUPLE [key: K; val: V]
			--returns the element with the largest key in the map
		local
			ma : INTEGER
		do
			ma := sorted_keys.upper
			Result := [sorted_keys[ma], values[ma]]
		end

end
