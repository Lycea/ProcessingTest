
from generate_md.paragraphVisitor import *
class cBodyVisitor():
    def visit(self,tree):
        print("Travers all paragraph nodes...")
        for node in tree.paragraphs:
            cParagraphVisitor().visit(node)