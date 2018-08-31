from parser.BaseParser import *
from parser.concerns import match_star

from parser.ParagraphParser import *
from parser.Node import *
from parser.BodyNode import *

class cBodyParser(cBaseParser):
    def match(self,tokens):
        result = match_star(tokens,cParagraphParser())
        if len(result[0]) == 0:
            return cNode.null()
        return cBodyNode(result[0],result[1])


