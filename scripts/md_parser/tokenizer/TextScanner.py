from tokenizer.token import *
from tokenizer.BaseScanner import *


        

class cTextScanner(cScanner):
     def from_string(self,raw_text):
         text=raw_text
         print("scanning text...")
         txt_token=""
         #iterate the string
         for char in text:
             #if it is not a token
             if cScanner.from_string(cScanner,char) == False:
                 #add to txt string
                 txt_token+=char
                 print(txt_token)
             else:
                 #done since there is something in between
                 break
        #check if has no content else return
         if txt_token == "":
             return cToken.null()
         else:
            print("return result...")
            return cToken("TEXT",txt_token)
