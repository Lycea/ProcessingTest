from tokenizer.token import *
from tokenizer.TokenList import *
from tokenizer.BaseScanner import *
from tokenizer.TextScanner import *
from tokenizer.HeaderScanner import *




class cTokenizer():
    def __init__(self):
        #self.tokens=[]
        self.tokens = cTokenList()
        self.md_text=""
        self.to_process_txt=""

    def setMdText(self,text):
        self.md_text=text
    
    #scan for a single token and return it
    def scann_single_token(self):
        scanners=[
            cScanner(), #finds special signs and converts them to tokens
            cTextScanner() #parses everything into a token till there is a special one
        ]

        #iterate over the given scanners for finding tokens
        for scanner in scanners:
            result =scanner.from_string(self.to_process_txt) 
            if result == cToken.null():
                continue
            else:
                return result
        raise "No match found for string"
            

    def scan_whole_text(self):
        self.to_process_txt = self.md_text

        if self.to_process_txt == "" or self.to_process_txt == None:
            self.tokens.add(cToken.end_of_file())
            return

        while self.to_process_txt != "" and self.to_process_txt != None:
            token =self.scann_single_token()
            self.to_process_txt=self.to_process_txt[token.getSize():]
            self.tokens.add(token)
        self.tokens.add(cToken.end_of_file())




    def start(self):
        self.scan_whole_text()