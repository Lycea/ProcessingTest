from parse_md.Node import *
from parse_md.BaseParser import *

from tokenizer.TokenList import *

class EmphasiseParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
           temp = cTokenList()
           temp.t_list = tokens
           tokens = temp
       if tokens.peek_or([["UNDERSCORE","TEXT","UNDERSCORE"],["STAR","TEXT","STAR"]])[0] == True:
           return cNode("EMPHASISE",tokens.getValueAt(2), 3)
       else:
            return cNode.null()