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

    end

    #'Parsing' identifiers
    def id()
        match(Token::ID)
    end

    #'Parsing' integers
    def int()
        match(Token::INT)
    end
    
end
