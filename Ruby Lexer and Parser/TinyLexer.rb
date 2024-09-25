#
#  Class Lexer - Reads a TINY program and emits tokens
#
class Lexer
    # Constructor - Is passed a file to scan and outputs a token
    #               each time nextToken() is invoked.
    #   @c        - A one character lookahead 
        def initialize(filename)
            # Need to modify this code so that the program
            # doesn't abend if it can't open the file but rather
            # displays an informative message
            @f = File.open(filename,'r:utf-8')
            
            # Go ahead and read in the first character in the source
            # code file (if there is one) so that you can begin
            # lexing the source code file 
            if (! @f.eof?)
                @c = @f.getc()
            else
                @c = "eof"
                @f.close()
            end
        end
        
        # Method nextCh() returns the next character in the file
        def nextCh()
            if (! @f.eof?)
                @c = @f.getc()
            else
                @c = "eof"
            end
            
            return @c
        end
    
        # Method nextToken() reads characters in the file and returns
        # the next token
        def nextToken() 
            if @c == "eof"
                return Token.new(Token::EOF,"eof")
                    
            elsif (whitespace?(@c))
                #handle whitespace
                str = ""
            
                while whitespace?(@c)
                    str += @c
                    nextCh()
                end
            
                tok = Token.new(Token::WS,str)
            
            elsif letter?(@c)
                #handle identifiers and keywords
                str = ""
                while letter?(@c)
                    str += @c
                    nextCh()
                end
    
                if str == "print"
                    tok = Token.new(Token::STMT,str)
                else
                    tok = Token.new(Token::ID,str)
                end
    
            elsif numeric?(@c)
                #handle integers
                str = ""
                while numeric?(@c)
                    str += @c
                    nextCh()
                end
                tok = Token.new(Token::INT,str)
    
            #handle operators	
            elsif @c == '+'
                nextCh()
                tok = Token.new(Token::ADDOP,'+')
    
            elsif @c == '-'
                nextCh()
                tok = Token.new(Token::SUBOP,'-')
    
            elsif @c == '*'
                nextCh()
                tok = Token.new(Token::MULOP,'*')
    
            elsif @c == '/'
                nextCh()
                tok = Token.new(Token::DIVOP,'/')
    
            elsif @c == '='
                nextCh()
                tok = Token.new(Token::ASSIGN,'=')
    
            elsif @c == '('
                nextCh()
                tok = Token.new(Token::LPAREN,'(')
    
            elsif @c == ')'
                nextCh()
                tok = Token.new(Token::RPAREN,')')
    
            else
                #handle unknowns
                tok = Token.new(Token::UNKWN,@c)
                nextCh()
            end
    
            print_token(tok)
            return tok
        end
    
        def print_token(token)
            puts "Next token is: #{token.get_type} Next lexeme is: #{token.get_text}"
        end
    end
    
    #
    # Helper methods for Scanner
    #
    def letter?(lookAhead)
        lookAhead =~ /^[a-z]|[A-Z]$/
    end
    
    def numeric?(lookAhead)
        lookAhead =~ /^(\d)+$/
    end
    
    def whitespace?(lookAhead)
        lookAhead =~ /^(\s)+$/
    end
    