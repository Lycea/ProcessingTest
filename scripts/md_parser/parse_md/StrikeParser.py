from parse_md.Node import *
from parse_md.BaseParser import *

from tokenizer.TokenList import *


class cStrikeParser(cBaseParser):
    def match(self,tokens):
        if type(tokens)==list:
           temp = cTokenList()
           temp.t_list = tokens
           tokens = temp
        if tokens.peek_or([["TILDE","TEXT","TILDE"]])[0] == True:
           return cNode("STRIKE",tokens.getValueAt(2), 3)
        else:
           return cNode.null()