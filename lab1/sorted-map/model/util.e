note
	description: "[
		This utility class contains a merge sort and
		concatenate of two arrays.
		You must complete the TO DO parts
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	UTIL [G -> COMPARABLE]

feature -- queries


	concatenate (a: ARRAY [G]; b: ARRAY [G]): ARRAY [G]
		require
			constraints_on_lower_indices:
				-- Do not modify this precondition.
				a.lower = 1 and b.lower = 1
		do
			create Result.make_empty
			-- TO DO
			Result.grow (a.count + b.count)
			Result.subcopy (a, a.lower, a.upper, 1)
			Result.subcopy (b, b.lower, b.upper, a.count + 1)

		ensure
			constraint_on_lower_index:
				-- Do not modify this postcondition.
				Result.lower = 1
			correct_size:
				-- TO DO: replace False with your postcondition.
				Result.count = a.count + b.count
			correct_contents:
				-- TO DO: replace False with your postcondition.
				-- The final result must be the concatenation of
				-- the two argument arrays.
				-- Hint: You may use `across' as a universal quantifier.
				across Result.lower |..| Result.upper as i
				all
					if i.item <= a.upper then
						Result [i.item] ~ a [i.item]
					else
						Result [i.item] ~ b [i.item - a.count]
					end
				end
		end

	merge (left, right: ARRAY[G]): ARRAY[G]
			-- Result is a sorted merge of `left' and `right'
		require
			left_sorted:
				-- TO DO: replace False with your precondition.
				across left.lower |..| left.upper as i
				all
					left [i.item] <= left [i.item + 1]
				end

			right_sorted:
				-- TO DO: replace False with your precondition.
				across right.lower |..| right.upper as i
				all
					right [i.item] <= right [i.item + 1]
				end
		local
			lc, rc: INTEGER
		do
			create Result.make_empty
			-- TO DO
			lc := left.lower
			rc := right.lower
			across Result.lower |..| Result.upper as i
				loop
					if left [lc] <= right [rc] then
						Result.force (left [lc], i.item)
						lc := lc + 1
					else
						Result.force (right [rc], i.item)
						rc := rc + 1
					end
				end

		ensure
			merge_count:
				-- TO DO: replace False with your postcondition.
				-- Hint: What is the size of Result?
				Result.count = left.count + right.count
			sorted_non_descending:
				-- TO DO: replace False with your postcondition.
				-- Hint: Result is sorted in a non-descending order.
				across Result.lower |..| Result.upper as i
					all
						Result [i.item + 1] >= Result [i.item]
					end
			merge_contains_left_and_right:
				-- TO DO: replace False with your postcondition.
				-- Hint: The result only contains elements from `left' and `right'.
				across Result.lower |..| Result.upper as i
					all
						left.has (Result [i.item]) or else right.has (Result[i.item])
					end
		end


	merge_sort(a: ARRAY[G]): ARRAY[G]
			-- reteurn a sorted version of array `a'
		local
			low, mid, high: INTEGER
			a1, a2: ARRAY[G]
		do
			create Result.make_from_array (a)
			low := a.lower
			high := a.upper
			if low < high then
				check a.count > 1 end
				mid := (low + high) // 2
				a1 := a.subarray (low, mid)
				a2 := a.subarray (mid + 1, high)
				a2.rebase (1)
				a1 := merge_sort (a1)
				a2 := merge_sort (a2)
				Result := merge (a1, a2)
			end
		ensure
			same_count:
				-- TO DO: replace False with your postcondition.
				-- Hint: What is the size of Result?
				Result.count = a.count
			sorted_non_descending:
				-- TO DO: replace False with your postcondition.
				-- Hint: Result is sorted in a non-descending order.
				across Result.lower |..| Result.upper as i
					all
						Result [i.item + 1] >= Result [i.item]
					end
			permutation: 
				-- TO DO: replace False with your postcondition.
				-- Hint: You may want to use {ARRAY}occurrences
				across Result.lower |..| Result.upper as i
					all
						Result.has (a [i.item])
					end

		end
end
