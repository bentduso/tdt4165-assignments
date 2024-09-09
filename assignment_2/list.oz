declare Length Take Drop Append Member Position FindPosition Push Peek Pop in
   fun {Length List}
      case List
      of nil then 0
      [] _|Tail then 1 + {Length Tail}
      end
   end

   fun {Take List Count}
      if Count == 0 then nil
      else if List == nil then nil
	   else List.1|{Take List.2 Count - 1} end
      end
   end

   fun {Drop List Count}
      if Count == 0 then List
      else if List == nil then nil
	   else {Drop List.2 Count - 1} end
      end
   end

   fun {Append List1 List2}
      if List1 == nil then List2
      else List1.1 | {Append List1.2 List2} end
   end

   fun {Member List Element}
      if List == nil then false
      else if List.1 == Element then true
	   else {Member List.2 Element} end
      end
   end

   fun {Position List Element}
      {FindPosition List Element 0}
   end

   fun {FindPosition List Element Acc}
      if List == nil then ~1
      else if List.1 == Element then Acc
	   else {FindPosition List.2 Element Acc + 1} end
      end
   end

   fun {Push List Element}
      Element|List
   end

   fun {Peek List}
      case List of Head|_ then Head
      else nil end
   end

   fun {Pop List}
      case List of _|Tail then Tail
      else nil end
   end
