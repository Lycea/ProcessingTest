from parser.BodyParser import *

class cParser():
    def parse(self,tokens):
        body =cBodyParser().match(tokens)
        if body[1] != tokens.count():
            raise "There is some error in the tokens"
        return body