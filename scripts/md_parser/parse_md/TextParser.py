from parse_md.BaseParser import *
from parse_md.Node import *


class cTextParser(cBaseParser):
    def match(self,tokens):
        if len(tokens) == 0:
            return False
        
        if tokens[0].type == "TEXT":
            print("is text create new node...")
            return cNode("TEXT",tokens[0].value,1)
        else:
            return False
