class cBoldItalicVisitor():
    def visit(self,node):
        return "<em><strong>"+node.value+"</strong></em>"