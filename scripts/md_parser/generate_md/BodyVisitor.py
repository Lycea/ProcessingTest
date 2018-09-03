
from generate_md.paragraphVisitor import *
class cBodyVisitor():
    def visit(self,tree):
        body_txt = ""
        print("Travers all paragraph nodes...")
        for node in tree.paragraphs:
            body_txt +=cParagraphVisitor().visit(node)
        return body_txt