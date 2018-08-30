from BaseParser import *
from Node import *


class cTextParser(cBaseParser):
    def match(self,tokens):
        if tokens[0].type == "TEXT":
            print("is text create new node...")
        else:
            return cNode("TEXT",tokens[0].value,1)
