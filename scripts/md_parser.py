import os
import sys
import re
import string

import datetime



#file to parse
f_name = "test.md"


#first parsing idea
"""
def check_headers(text):
    #check for hashtag at start "#"
    header = re.search("(#*) .*",text)
    print(text.strip())
    if header != None:
        result =list(filter(None,header.groups()))
        if len(result) >0:
            print("header")
            #so which one is it ?
            if len(result[0])< 6:
                print("<h"+str(len(result[0]))+">")

                #check if there is another one at the and
                result_ = re.search("#"*len(result[0])+" [^#]* "+"#"*len(result[0]),text)
                if result_ != None:
                    #is double header
                    text = re.search("#"*len(result[0])+" (.*) "+"#"*len(result[0]),text).groups()[0]
                    print(text)
                    print("double header")
                else:
                    print(result)
                    text = re.search("#"*len(result[0])+" (.*)",text).groups()[0]
                    print(text)
                    #single header


           

def check_decorators():
    print("")


md_text = open(f_name,"r")




time= datetime.datetime.now()
for line in md_text:
    
    #print(line.strip())
    string_result = check_headers(line)
    print("----")
#print((datetime.datetime.now()-time).microseconds)
    
"""

parsable_text = "A text section __with__ some *deco*"
samples=[
    "_test*",
    "__bold__",
    "*emphazized*"
]
#more compiler like way ? (sample)

#the token class wich can define all types of tokens
class cToken():
    def __init__(self,type_="NONE",value_="NONE"):
        self.type = type_
        self.value =value_

    #create an end of file token
    @staticmethod
    def end_of_file():
        #print("end of file")
        return cToken("EOF","")

    #not a token :P
    @staticmethod
    def null():
        return False

    def getSize(self):
        return len(self.value)


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
             return cToken.null
         else:
            print("return result...")
            return cToken("TEXT",txt_token)



         

    

class cTokenizer():
    def __init__(self):
        self.tokens=[]
        self.md_text=""
        self.to_process_txt=""

    def setMdText(self,text):
        self.md_text=text
    
    #scan for a single token and return it
    def scann_single_token(self):
        scanners=[
            cScanner(),
            cTextScanner()
        ]

        for scanner in scanners:
            result =scanner.from_string(self.to_process_txt) 
            if result == cToken.null():
                continue
            else:
                print("Result "+result.value)
                return result
        raise "No match found for string"
            

    def scan_whole_text(self):
        self.to_process_txt = self.md_text
        print("scanning everything...")

        if self.to_process_txt == "" or self.to_process_txt == None:
            self.tokens.append(cToken.end_of_file())
            return

        print(self.to_process_txt)
        while self.to_process_txt != "" and self.to_process_txt != None:
            token =self.scann_single_token()
            print(token)
            self.to_process_txt=self.to_process_txt[token.getSize():]
            self.tokens.append(token)
            print(self.to_process_txt)
        self.tokens.append(cToken.end_of_file())




    def start(self):
        self.scan_whole_text()




token_checker = cTokenizer()
token_checker.setMdText("Far *more* complex _test_\n test test __teset__")
token_checker.start()

for token in token_checker.tokens:
    print(token.value+" "+token.type)


#info websites
#https://spec.commonmark.org/0.26/
##tutorial
#https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/