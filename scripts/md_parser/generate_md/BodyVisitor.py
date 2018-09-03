
from generate_md.paragraphVisitor import *
class cBodyVisitor():
    def visit(self,tree):
        body_txt = ""
        for node in tree.paragraphs:
            body_txt +=cParagraphVisitor().visit(node)
        return body_txt