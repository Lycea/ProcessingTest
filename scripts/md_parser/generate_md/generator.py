from generate_md.BodyVisitor import *

class cGenerator():
    def generate(self,tree):
       return cBodyVisitor().visit(tree)