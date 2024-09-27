#
#  Parser Class
#
load "TinyToken.rb"
load "TinyLexer.rb"
class Parser < Lexer
	def initialize(filename)
    	super(filename)
    	consume()
   	end
   	
	def consume()
      	@lookahead = nextToken()
      	while(@lookahead.type == Token::WS)
        	@lookahead = nextToken()
      	end
   	end
  	
	def match(dtype)
      	if (@lookahead.type != dtype)
         	puts "Expected #{dtype} found #{@lookahead.text}"
        else 
            puts "Found #{@lookahead.type} Token: #{@lookahead.text}"
      	end
      	consume()
   	end
   	
	def program()
      	while( @lookahead.type != Token::EOF)
        	puts "Entering STMT Rule"
			statement()  
      	end
   	end

	def statement()
		if (@lookahead.type == Token::PRINT)
			puts "Found PRINT Token: #{@lookahead.text}"
			match(Token::PRINT)
			puts "Entering EXP Rule"
			exp()
		else
			puts "Entering ASSGN Rule"
			assign()
		end
		
		puts "Exiting STMT Rule"
	end
    
    def assign()
        if (@lookahead != nil)
            id()
            match(Token::ASSGN)
            puts "Entering EXP Rule"
            exp()
        end
        puts "Exiting ASSGN Rule"
     end
                    
     def exp()
         if (@lookahead != nil)
             puts "Entering TERM Rule"
             term()
             puts "Entering ETAIL Rule"
             etail()
         end
         puts "Exiting EXP Rule"
     end
                    
     def term()
         if (@lookahead != nil)
             puts "Entering FACTOR Rule"
             factor()
             puts "Entering TTAIL Rule"
             ttail()
         end
         puts "Exitng TERM Rule"
      end
                  
      def factor()
          if (@lookahead.type == Token::LPAREN)
              match(Token::LPAREN)
              puts "Entering EXP Rule"
              exp()
              match(Token::RPAREN)
          elsif
              int()
          else
              id()
          end
          puts "Exiting FACTOR Rule"
      end
                
      def etail()
          if (@lookahead.type == Token::ADDOP)
              match(Token::ADDOP)
              puts "Entering TERM Rule"
              term()
              puts "Entering ETAIL Rule"
              etail()
          elsif (@lookahead.type == Token::SUBOP)
              match(Token::SUBOP)
              puts "Entering TERM Rule"
              term()
              puts "Entering ETAIL Rule"
              etail()
          else
              puts "Did not find ADDOP of SUBOP Token, choosing EPSILON production"
              return
          end
          puts "Exiting ETAIL Rule"
       end
                    
       def ttail()
           if (@lookahead.type == Token::MULTOP)
               match(Token::MULTOP)
               puts "Entering FACTOR Rule"
               factor()
               puts "Entering TTAIL Rule"
               ttail()
           elsif (@lookahead.type == Token::DIVOP)
               match(Token::DIVOP)
               puts "Entering FACTOR Rule"
               factor()
               puts "Entering TTAIL Rule"
               ttail()              
           else
               puts "did not find MULTOP of DIVOP Token, choosing EPSILON production"
               return
           end
           puts "Exiting TTAIL Rule"
       end
                  
       def id()
           match(Token::ID)
       end
                    
       def int()
           match(Token::INT)
       end
               
end
