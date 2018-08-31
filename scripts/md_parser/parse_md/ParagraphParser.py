from parser.BaseParser import *
from parser.concerns import match_first

from parser.SentenceAndNewlineParser import *
from parser.SentencesAndEOFParser import *

class cParagraphParser(cBaseParser):
    def match(self,tokens):
        return match_first(tokens,[cSentenceAndNewlineParser(),cSentenceAndEofParser()])
