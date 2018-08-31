from parse_md.BaseParser import *
from parse_md.concerns import match_star

from parse_md.ParagraphParser import *
from parse_md.Node import *
from parse_md.BodyNode import *



class cBodyParser(cBaseParser):
    def match(self,tokens):
        result = match_star(tokens,cParagraphParser())
        if len(result[0]) == 0:
            return cNode.null()
        return cBodyNode(result[0],result[1])


