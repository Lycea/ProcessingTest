from parser.BaseParser import *
from parser.SentenceParser import *
from parser.concerns import match_star

from parser.Node import *
from parser.ParagraphNode import *

#match all "sentences" in a line
class cSentenceAndNewlineParser(cBaseParser):
    def match(self,tokens):
        result = match_star(tokens,cSentenceParser())

        #TODO check if this works correct, could be wrong by one
        if len(result[0]) == 0:
            return cNode.null()

        if tokens.peek_idx(result[1],"NEWLINE") and tokens.peek_idx(result[1]+1,"NEWLINE"):
            result[1] += 2

            return cParagraphNode(result[0],result[1])
        else:
            return cNode.null()
            
        
        
