from generate_md.BoldVisitor import *
from generate_md.EmphasiseVisitor import *
from generate_md.TextVisitor import *

class cSentenceVisitor():
    def __init__(self):
        self.TYPES={
            "TEXT":cTextVisitor(),
            "BOLD":cBoldVisitor(),
            "EMPHASISE":cEmphasiseVisitor()
        }
    def visit(self,tree):
        concat_txt = ""
        #print("parsing sentence...")
        if type(tree)==list:
            for node in tree:
                #print(node.type)
                 concat_txt+=self.TYPES[node.type].visit(node)
        else:
            #print(tree.type)
            concat_txt+=self.TYPES[tree.type].visit(tree)

        return concat_txt