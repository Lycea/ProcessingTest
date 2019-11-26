from parse_md.Node import *
from parse_md.BaseParser import *

from tokenizer.TokenList import *




class cNewlineParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp

       if tokens.peek("NEWLINE"):
          return cNode("NEWLINE"," ",1)
       else:
          return cNode.null()

class cBreakParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp

       if tokens.peek("NEWLINE"):
            or_res =tokens.peek_or([["NEWLINE","NEWLINE"],["NEWLINE","EOF"]])
            print(or_res)
            if or_res[0] == False:
                return cNode("BREAK"," ", 1)
            else:
                return cNode.null()
       else:
            return cNode.null()