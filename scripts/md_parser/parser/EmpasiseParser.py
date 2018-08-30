from parser.Node import *
from parser.BaseParser import *

class EmphasiseParser(cBaseParser):
    def match(self,tokens):
       if tokens.peek_or([["UNDERSCORE","TEXT","UNDERSCORE"],["STAR","TEXT","STAR"]])[0] == True:
           return cNode("BOLD",tokens.getValueAt(2), 3)
       else:
            return cNode.null()