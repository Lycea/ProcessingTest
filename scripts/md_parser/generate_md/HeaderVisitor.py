class cHeaderVisitor():
    def visit(self,node):
        print(node)
        print(node.value)
        print(node.type)
        number = node.type[len("HEADER"):]
        print(number)
        return "<h"+str(number)+">"+node.value+"</h"+str(number)+">"