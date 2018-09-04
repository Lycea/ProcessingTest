from parse_md.BaseParser import *
from parse_md.Node import  *
from tokenizer.TokenList import  *


class cBoldAndItalicParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp
          cases =[
               ["UNDERSCORE", "UNDERSCORE", "UNDERSCORE", "TEXT", "UNDERSCORE", "UNDERSCORE", "UNDERSCORE"],
               ["STAR", "STAR", "STAR", "TEXT", "STAR", "STAR", "STAR"],
               ["UNDERSCORE", "STAR", "STAR", "TEXT", "STAR", "STAR", "UNDERSCORE"],
               ["STAR", "UNDERSCORE", "UNDERSCORE", "TEXT", "UNDERSCORE", "UNDERSCORE", "STAR"]
           ]

       if tokens.peek_or(cases)[0] == True:
           return cNode("BOLDITALIC",tokens.getValueAt(4), 7)
       else:
            return cNode.null()

