declare QuadraticEquation RightFold Length Quadratic LazyNumberGenerator Sum DoSum in
proc {QuadraticEquation A B C}
   RealSol
   X1
   X2
   Discriminant = B*B - 4.0*A*C
in
   if Discriminant >= 0.0 then
      RealSol = true
      X1 = (~B + {Float.sqrt Discriminant}) / (2.0*A)
      X2 = (~B - {Float.sqrt Discriminant}) / (2.0*A)
   else
      RealSol = false
      X1 = X2 = noSol
   end
end

fun {RightFold List Op U}
   case List
   of nil then U
   [] Head|Tail then {Op Left {Rightfold Tail Op U}}
   end
end

fun {Length List}
   {Rightfold List fun {$ _ Y} Y + 1 end 0}
end

fun {Quadratic A B C}
   fun {$ X}
      A*X*X + B*X + C
   end
end

fun {LazyNumberGenerator StartValue}
   [StartValue {LazyNumberGenerator StartValue + 1}]
end

fun {Sum List}
   fun {DoSum List Acc}
      case List
      of nil then Acc
      [] Head|Tail then {DoSum Tail Acc}
      end
   end
in
   {DoSum List 0}
end