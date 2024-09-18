\insert './list.oz'

declare Lex Tokenize Interpret DoInterpret Compute Unwrap ExpressionTree ExpressionTreeInternal in
fun {Lex Input}
   {String.tokens Input & }
end

fun {Tokenize Lexemes}
   {Map Lexemes
    fun {$ Lexeme}
       case Lexeme
       of "+" then operator(type:plus)
       [] "-" then operator(type:minus)
       [] "*" then operator(type:multiply)
       [] "/" then operator(type:divide)
       [] "p" then command(print)
       [] "d" then command(duplicate)
       [] "i" then command(negate)
       [] "c" then command(clear)
       else
	  try number({String.toInt Lexeme})
	  catch _ then raise "invalid" end
	  end
       end
    end}
end

fun {Interpret Tokens}
   {Unwrap {DoInterpret nil Tokens}}
end

fun {DoInterpret Stack Tokens}
   case Tokens
   of nil then Stack
   [] Head|Tail then
      case Head
      of number(_) then {DoInterpret Head|Stack Tail}
      [] operator(type:Op) then 
         if {Length Stack} < 2 then
            raise "not enough operands for operator" end
         else
            case Stack of Right|Left|Rest then
               {DoInterpret {Compute Left Right Op}|Rest Tail}
            end
	 end
      [] command(print) then
	 {Show {Unwrap Stack}}
	 {DoInterpret Stack Tail}
      [] command(duplicate) then
	 case Stack of Top|Rest then
	    {DoInterpret Top|Top|Rest Tail}
	 end
      [] command(negate) then
	 case Stack of number(N)|Rest then
	    {DoInterpret number(~N)|Rest Tail}
	 end
      [] command(clear) then {DoInterpret nil Tail}
      end
   end
end

fun {Compute Left Right Op}
   case Op
   of plus then number(Left.1 + Right.1)
   [] minus then number(Left.1 - Right.1)
   [] multiply then number(Left.1 * Right.1)
   [] divide then number(Left.1 / Right.1)
   else raise "unknown operator" end
   end
end

fun {Unwrap List}
   {Map List fun {$ Token} Token.1 end}
end

fun {ExpressionTree Tokens}
   {ExpressionTreeInternal Tokens nil}
end

fun {ExpressionTreeInternal Tokens ExpressionStack}
   case Tokens
   of nil then
      case ExpressionStack
      of Head|_ then Head
      else raise "invalid expression" end
      end
   [] Head|Tail then
      case Head
      of number(N) then {ExpressionTreeInternal Tail N|ExpressionStack}
      [] operator(type:Op) then
	 if {Length ExpressionStack} < 2 then
            raise "not enough operands for operator" end
         else
	    case ExpressionStack of Left|Right|Rest then
	       case Op
               of plus then {ExpressionTreeInternal Tail plus(Left Right)|Rest}
               [] minus then {ExpressionTreeInternal Tail minus(Left Right)|Rest}
               [] multiply then {ExpressionTreeInternal Tail multiply(Left Right)|Rest}
               [] divide then {ExpressionTreeInternal Tail divide(Left Right)|Rest}
               else raise "unknown operator" end
               end
            end
	 end
      else raise "invalid token" end
      end
   end
end