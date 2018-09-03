from parse_md.BodyParser import *

class cParser():
    def parse(self,tokens):
        body =cBodyParser().match(tokens)
        if body == False:
            print("Error while parsing the text")
        if body.consumed != tokens.count():
            print(str(body.consumed)+" "+str(tokens.count()))
            print("The token count dosn't match something is wrong")
        else:
            print(str(body.consumed)+" "+str(tokens.count()))
        return body