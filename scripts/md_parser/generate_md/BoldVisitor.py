class cBoldVisitor():

    def visit(self,node):
        return "<strong>"+node.value+"</strong>"