{Browse 'Hello, World!'}

local X Y Z in
    Y = 300
    Z = 30
    X = Y * Z
end

local X Y in
    X = "This is a string"
    thread {System.showInfo Y} end
    Y = X
end

local Max in
   fun {Max Number1 Number2}
      if Number1 >= Number2 then Number1
      else Number2 end
   end
end

local PrintGreater in
   proc {PrintGreater Number1 Number2}
      {System.showInfo {Max Number1 Number2}}
   end
end

local Circle in
   proc {Circle R}
      PI = 355.0 / 113.0
      D = 2.0 * R
      A = PI * R * R
      C = PI * D
   in
      {Show D}
      {Show A}
      {Show C}
   end
end

local Factorial in
   fun {Factorial N} % see the PDF for the other implementation
      case N of 0 then 1
      else N * {Factorial N-1} end
   end
end

local Length in
   fun {Length List}
      case List
      of nil then 0
      [] Head|Tail then 1 + {Length Tail}
      end
   end
end

local Take in
   fun {Take List Count}
      if Count == 0 then nil
      else if List == nil then nil
	   else List.1|{Take List.2 Count - 1} end
      end
   end
end

local Drop in
   fun {Drop List Count}
      if Count == 0 then List
      else if List == nil then nil
	   else {Drop List.2 Count - 1} end
      end
   end
end

local Member in
   fun {Member List Element}
      if List == nil then false
      else if List.1 == Element then true
	   else {Member List.2 Element} end
      end
   end
end

local Append in
   fun {Append List1 List2}
      if List1 == nil then List2
      else List1.1 | {Append List1.2 List2} end
   end
end

local Position FindPosition in
   fun {Position List Element}
      {FindPosition List Element 0}
   end

   fun {FindPosition List Element Acc}
      if List == nil then ~1
      else if List.1 == Element then Acc
	   else {FindPosition List.2 Element Acc + 1} end
      end
   end
end

local Push in
   fun {Push List Element}
      Element|List
   end
end

local Peek in
   fun {Peek List}
      case List of Head|Tail then Head
      else nil end
   end
end

local Pop in
   fun {Pop List}
      case List of Head|Tail then Tail
      else nil end
   end
end
