from parse_md.BaseParser import *
from parse_md.concerns import match_first

from parse_md.SentenceAndNewlineParser import *
from parse_md.SentencesAndEOFParser import *

class cParagraphParser(cBaseParser):
    def match(self,tokens):
        return match_first(tokens,[cSentenceAndNewlineParser(),cSentenceAndEofParser()])
