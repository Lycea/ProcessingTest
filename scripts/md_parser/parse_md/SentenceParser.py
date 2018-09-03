from parse_md.BaseParser import *
from parse_md.BoldParser import *
from parse_md.EmpasiseParser import *
from parse_md.TextParser import *
from parse_md.StrikeParser import *

from parse_md.concerns import match_first


#parses one "Sentence" 
class cSentenceParser(cBaseParser):
    def match(self,tokens):
        return match_first(tokens,[cStrikeParser(), EmphasiseParser(),BoldParser(),cTextParser()])