from parse_md.BaseParser import *
from parse_md.Node import  *
from tokenizer.TokenList import  *


class cBoldAndItalicParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp
          if tokens.peek("HASH"):
            return cNode("HEADER","#")

          return cNode.null()