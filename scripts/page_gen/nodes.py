# class cNode():
#     def __init__(self,type_="NONE",value_="NONE",consumed="0"):
#         self.type = type_
#         self.value= value_
#         self.consumed = consumed
    
#     @staticmethod
    # def null():
#        return False


from md_parser.parse_md.Node import cNode

class cConditionTemplate(cNode):
    def __init__(self,condition_parts,true_parts,false_parts):
        self.type = "CONDITION"
        self.condition_type ="FUNCTION"

        self.condition_parts = condition_parts
        self.true_parts = true_parts
        self.false_parts = false_parts
        self.consumed = 0

class cLoopTemplate(cNode):
    def __init__(self,loop_condition, loop_content):
        self.type = "LOOP"

        self.loop_condition = loop_condition
        self.loop_content = loop_content
        self.consumed = 0

class cImportTemplate(cNode):
    def __init__(self, path):
        self.type = "IMPORT"

        self.consumed = 0
        self.path = path

class cFunction(cNode):
    def __init__(self ):
        self.type = "FUNCTION"

        self.consumed = 0
        self.name = "n/a"
        self.parameters =[]

class cVariable(cNode):
    set = "SET"
    get = "GET"

    def __init__(self,name):
        self.name = name
        self.type = "VARIABLE"
        self.var_type = "GET"


class cParameter(cNode):
    def __init__(self,sub_type_,value_,consumed_) :
        self.type = "PARAMETER"
        self.consumed = consumed_
        self.value = value_
        self.sub_type = sub_type_
