from generate_md.senctenceVisitor import *

class cParagraphVisitor():
    def visit(self,tree):
      
        print("start parsing graph...")
        generated_txt = "<p>"
        for nodes in tree.sentences:
            generated_txt += cSentenceVisitor().visit(nodes)
            print(nodes)
        generated_txt+="</p>"