#the token class wich can define all types of tokens
class cToken():
    def __init__(self,type_="NONE",value_="NONE"):
        self.type = type_
        self.value =value_

    #create an end of file token
    @staticmethod
    def end_of_file():
        #print("end of file")
        return cToken("EOF","")

    #not a token :P
    @staticmethod
    def null():
        return False

    def getSize(self):
        return len(self.value)