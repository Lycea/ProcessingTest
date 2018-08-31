from parse_md.BaseParser import *
from parse_md.SentenceParser import *
from parse_md.concerns import match_star

from parse_md.Node import *
from parse_md.ParagraphNode import *

from tokenizer.TokenList import *

#match all "sentences" in a line
class cSentenceAndNewlineParser(cBaseParser):
    def match(self,tokens):
        result = match_star(tokens,cSentenceParser())

        #TODO check if this works correct, could be wrong by one
        if len(result[0]) == 0:
            return cNode.null()

        if type(tokens)==list:
            tmp =cTokenList()
            tmp.t_list = tokens
            tokens = tmp
            
        if tokens.peek_idx(result[1],"NEWLINE") and tokens.peek_idx(result[1]+1,"NEWLINE"):
            result[1] += 2

            return cParagraphNode(result[0],result[1])
        else:
            return cNode.null()
            
        
        
