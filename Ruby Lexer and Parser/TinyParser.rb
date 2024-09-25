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

    #Parsing expressions
    def exp() 
        if @lookAhead.type == Token::ID
            id()
        else @lookAhead.type == Token::INT
            int()
        end
    end

    #Parsing assignments
    def assign()
		if (@lookahead.type == Token::ID)
			id()
			match(Token::ASSGN)
			puts "Entering EXP Rule"
			exp()
		else
			puts "Error in assign rule"
		end
    end

    #'Parsing' identifiers
    def id()
		puts "Found ID Token: #{@lookahead}"
        match(Token::ID)
    end

    #'Parsing' integers
    def int()
		puts "Found INT Token: #{@lookahead}"
        match(Token::INT)
    end

	#Parsing additon and subtraction
	def etail()
		puts "Entering ETAIL Rule"
		if (@lookahead.type == Token::ADDOP || @lookahead.type == Token::SUBOP)
			addop()
			puts "Entering EXP Rule"
			exp()
			puts "Entering ETAIL Rule"
			etail()
		else
			puts "Exiting ETAIL Rule"
		end


end
