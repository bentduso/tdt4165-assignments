\insert './streams.oz'

declare Enumerate Primes in
fun lazy {Enumerate}
   fun lazy {EnumerateFrom Number}
      Number|{EnumerateFrom Number + 1}
   end
in
   {EnumerateFrom 1}
end

fun lazy {Primes}
   fun lazy {LazyFilter List Pred}
      case List
      of Head|Tail then
	 if {Pred Head} then Head|{LazyFilter Tail Pred}
	 else {LazyFilter Tail Pred} end
      end
   end
in
   {LazyFilter {Enumerate} IsPrime}
end
