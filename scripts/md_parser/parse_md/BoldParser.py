from parse_md.Node import *
from parse_md.BaseParser import *

from tokenizer.TokenList import *

class BoldParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp

       if tokens.peek_or([["UNDERSCORE","UNDERSCORE","TEXT","UNDERSCORE","UNDERSCORE"],["STAR","STAR","TEXT","STAR","STAR"]])[0] == True:
           return cNode("BOLD",tokens.getValueAt(3), 5)
       else:
            return cNode.null()
