from parser.BaseParser import *
from parser.concerns import match_star
from parsers.SentenceParser import *

from parsers.Node import *
from parser.ParagraphNode import *

class cSentenceAndEofParser(cBaseParser):
    def match(self,tokens):
        result =match_star(tokens,cSentenceParser())
        if len(result[0]) == 0:
            return cNode.null()

        if tokens.peek_idx(result[1],"EOF"):
            result[1]+=1
        else:
            if tokens.peek_idx(result[1],"NEWLINE") and tokens.peek_idx(result[1]+1,"EOF"):
                result[1]+=2
            else:
                return cNode.null()
        return cParagraphNode(result[0],result[1])