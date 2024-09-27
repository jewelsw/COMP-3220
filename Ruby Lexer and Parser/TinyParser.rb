#
#  Parser Class
#
load "TinyToken.rb"
load "TinyLexer.rb"
class Parser < Lexer
	errorCount = 0

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
			errorCount += 1
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

	#Parsing assignments
    def assign()
		if (@lookahead != nil)
			id()
			match(Token::ASSGN)
			puts "Entering EXP Rule"
			exp()
		end
    end

    #Parsing expressions
    def exp() 
		if (@lookahead != nil)
			puts "Entering TERM Rule"
        	term() 
			puts "Entering ETAIL Rule"
			etail()
		end
		puts "Exiting EXP Rule"
    end

	#Parsing terms
	def term()
		if (@lookahead != nil)
			puts "Entering FACTOR Rule"
			factor()
			puts "Entering TTAIL Rule"
			ttail()
		end
		puts "Exiting TERM Rule"
	end

	#Parsing right and left parenthesis
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

	#Parsing additon and subtraction
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
			return
		end
	end

	#Parsing multiplication and division
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
			return
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

	puts "Errors found: #{errorCount}"
end
