from parser.Node import *
from parser.BaseParser import *

class BoldParser(cBaseParser):
    def match(self,tokens):
       if tokens.peek_or([["UNDERSCORE","UNDERSCORE","TEXT","UNDERSCORE","UNDERSCORE"],["STAR","STAR","TEXT","STAR","STAR"]])[0] == True:
           return cNode("BOLD",tokens.getValueAt(3), 5)
       else:
            return cNode.null()
