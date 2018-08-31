from parser.BaseParser import *
from parser.BoldParser import *
from parser.EmpasiseParser import *
from parser.TextParser import *

from parser.concerns import match_first


#parses one "Sentence" 
class cSentenceParser(cBaseParser):
    def match(self):
        return match_first(tokens,[cEmpasiseParser(),cBoldParser(),cTextParser()])
