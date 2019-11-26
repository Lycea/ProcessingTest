from parse_md.BodyParser import *

class cParser():

    def __preprocess(self,tokens):
        last_newline = -1
        consecutive_hash = 0
        for token_id in range(len(tokens.t_list)):
            if tokens.t_list[token_id].type == "NEWLINE":
                last_newline = token_id 
            elif tokens.t_list[token_id].type == "HASH":
                if token_id == last_newline+1 or consecutive_hash >0:
                    consecutive_hash +=1
                else:
                    tokens.t_list[token_id].type = "TEXT"
                    tokens.t_list[token_id].value = "#"
            else:
                consecutive_hash = 0
                    

        return tokens
    def parse(self,tokens):
        self.__preprocess(tokens)
        print("preprocess the tokens...")

        body =cBodyParser().match(tokens)
        if body == False:
            print("Error while parsing the text")
        if body.consumed != tokens.count():
            print(str(body.consumed)+" "+str(tokens.count()))
            print("The token count dosn't match something is wrong")
            print("Last successfull consumed was:",tokens.t_list[body.consumed])
        else:
            print(str(body.consumed)+" "+str(tokens.count()))
        return body