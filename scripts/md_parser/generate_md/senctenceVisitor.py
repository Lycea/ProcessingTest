from generate_md.BoldVisitor import *
from generate_md.EmphasiseVisitor import *
from generate_md.TextVisitor import *
from generate_md.StrikeVisitor import *
from generate_md.BreakVisitor import *
from generate_md.BoldItalicVisitor import *
from generate_md.HeaderVisitor import *

class cSentenceVisitor():
    def __init__(self):
        self.TYPES={
            "TEXT":cTextVisitor(),
            "BOLD":cBoldVisitor(),
            "EMPHASISE":cEmphasiseVisitor(),
            "STRIKE":cStrikeVisitor(),
            "BREAK":cBreakVisitor(),
            "BOLDITALIC":cBoldItalicVisitor(),
            "HEADER1":cHeaderVisitor(),
            "HEADER2":cHeaderVisitor(),
            "HEADER3":cHeaderVisitor(),
            "HEADER4":cHeaderVisitor(),
            "HEADER5":cHeaderVisitor()
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