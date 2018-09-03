from parse_md.BaseParser import *
from parse_md.Node import *


#Parses everything what is not parseable to a text :P
class cDefaultParser(cBaseParser):
    def match(self,tokens):
        if len(tokens) == 0:
            return False
        print(tokens[0])
        if  tokens[0].type=="NEWLINE" or tokens[0].type=="EOF":
            return False
        return cNode("TEXT",tokens[0].value,1)
