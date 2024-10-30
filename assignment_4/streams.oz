declare Enumerate GenerateOdd ListDivisorsOf IsPrime ListPrimesUntil ShowStream in
fun {Enumerate Start End}
   if Start > End then nil
   else Start|thread {Enumerate Start+1 End} end
   end
end

fun {GenerateOdd Start End}
   fun {IsOdd Number}
      Number mod 2 == 1
   end
in 
   thread {Filter {Enumerate Start End} IsOdd} end
end

fun {ListDivisorsOf Number}
   fun {IsDivisorOf X Y}
      Y mod X == 0
   end
in
   thread
      {Filter {Enumerate 1 Number}
       fun {$ X} {IsDivisorOf X Number} end}
   end
end

fun {IsPrime Number}
   case {ListDivisorsOf Number}
   of [1 Number] then true
   else false
   end
end

fun {ListPrimesUntil Number}
   thread {Filter {Enumerate 2 Number} IsPrime} end
end

proc {ShowStream List}
   case List of _|Tail then
      {Browse List.1}
      thread {ShowStream Tail} end
   else
      skip
   end
end
