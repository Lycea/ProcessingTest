from parse_md.Node import *

#return the first found result
def match_first(tokens,parsers):
    for parser in parsers:
        node = parser.match(tokens)
        if node == False or node == None:
            continue 
        else:
            return node
    return cNode.null()

#try to match  as much as possible
def match_star(tokens,parser):
    matched_nodes = []
    consumed      = 0

    while True:
        if type(tokens) != list: 
            node = parser.match(tokens.t_list[consumed:])
            if node != False:
                matched_nodes.append(node)
                consumed +=node.consumed
            else:
                break
        else:
            node = parser.match(tokens[consumed:])
            if node != False:
                matched_nodes.append(node)
                consumed +=node.consumed
            else:
                break
    
    return [matched_nodes,consumed]




def match_plus(tokens,parser):
    result = match_star(tokens,parser)
    if len(result[0])== 0:
        return False
    else:
        return result