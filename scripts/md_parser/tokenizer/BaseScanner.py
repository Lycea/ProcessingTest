from tokenizer.token import *



class cScanner():
    #need to implement that allways ... does the work
    def from_string(self,raw_text):
        #list of single tokens that are able to be parsed
        self.TOKENS={
          "_":'UNDERSCORE',
          "*":"STAR",
          "\n":"NEWLINE"  
        }
        #get first string and check
        char = raw_text[0]
        if char in self.TOKENS:
            return cToken(self.TOKENS[char],char)
        else:
            return cToken.null()