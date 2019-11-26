from generate_md.senctenceVisitor import *

class cParagraphVisitor():
    def visit(self,tree):
      
        generated_txt = "<p>"
        for nodes in tree.sentences:
            generated_txt += cSentenceVisitor().visit(nodes)
        generated_txt+="</p>\n"

        return generated_txt