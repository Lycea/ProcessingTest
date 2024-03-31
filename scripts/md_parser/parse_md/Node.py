class cNode():
    def __init__(self,type_="NONE",value_="NONE",consumed="0"):
        self.type = type_
        self.value= value_
        self.consumed = consumed
    
    @staticmethod
    def null():
        return False
