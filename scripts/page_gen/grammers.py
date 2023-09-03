
from md_parser.parse_md.Node import cNode
import md_parser.tokenizer.TokenList as TokenList
import md_parser.parse_md.concerns

import tokens
import nodes

t = tokens.toks()


def match_template_end(tok_list):
    tok_list = retype_tokens(tok_list)
    match_res = tok_list.peek_or([[t.BRACE_CLOSE, t.BRACE_CLOSE]])

    return match_res[0]

def match_template_start(tok_list):
    tok_list = retype_tokens(tok_list)
    match_res = tok_list.peek_or([[t.BRACE_OPEN, t.BRACE_OPEN]])
    
    return match_res[0]


print("imp parser")
concerns = None

class PrintHelper():
    def __init__(self):
        self.lvl = 0

    def u(self):
        self.lvl +=1
        return self

    def d(self):
        self.lvl -=1
        return self

    def print(self,txt):
        lines = txt.split("\n")
        for line in lines:
            print(f"{self.lvl*'  '}{line}" )


p = PrintHelper()

#fix token list problem ...
def retype_tokens(tokens):
    if type(tokens) == type([]):
        tmp = TokenList.cTokenList()
        tmp.t_list = tokens
        return tmp
    else:
        return tokens


class PathPart():
    def match(self, token_list):
        p.u().print("")
        p.print("PathSearch")
        ret = cNode.null()

        token_list = retype_tokens(token_list)
        print_first_few(token_list)

        next_possible ={
            t.SLASH : [ t.STRING ],
            t.STRING: [ t.SLASH, t.SPACE, t.BRACE_CLOSE ]
        }

        cur_type = t.SLASH
        count = 0
        txt = ""

        if token_list.peek_idx(0, t.SPACE):
            count = 1

        while cur_type in next_possible.keys():
            next_valid = token_list.t_list[count].type in next_possible[cur_type]
            if not next_valid:
                break
            
            cur_type = token_list.t_list[count].type

            if cur_type in next_possible.keys():
                txt+=token_list.t_list[count].value
                count += 1
        else:
            p.print("Valid path syntax!")
            p.print(" "+txt)
            path_parse_success = True

            ret = cNode("PATH", txt, count)
        p.print("PATH SEARCH DONE")
        p.d()

        return ret




class ImportTemplate():
    def string_path(self,token_list):
        pass

    def match(self,token_list):
        p.u().print("Import")
        ret = cNode.null()

        token_list = retype_tokens(token_list)
        print_first_few(token_list)
        res = token_list.peek_or(
            [
                [t.SPACE, t.STRING, t.COLON],
                [t.STRING,t.COLON],
            ])

        if res[0] == True:
            p.u().print("REAL")

            p.print(token_list.getValueAt(1))
            p.print(token_list.getValueAt(2))

            if res[1] == 2:
                p.print(str(2))
                if token_list.getValueAt(1) == "TEMPLATE":
                    p.u().print("IMPORT FOUND")
                    p.d()

                    matched = md_parser.parse_md.concerns.match_plus( token_list.t_list[2:] ,PathPart())

                    print("match",matched)
                    ret = cNode("ImportTemplate","",res[1])
            else:
                p.print(str(res[1]))
                if token_list.getValueAt(2)=="TEMPLATE":
                    p.u().print("IMPORT FOUND")
                    p.d()
                    
                    ret = cNode("ImportTemplate","",res[1])

        p.d().d()
        return ret
    
class ConditionTemplate():
    def match(self,token_list):
        p.u().print("Condition")

        token_list = retype_tokens(token_list)
        res = token_list.peek_or(
            [
                [t.SPACE, t.STRING, t.COLON],
                [t.STRING,t.COLON],
            ])


        p.print(str(res))
        p.d()
        pass

class RepeatTemplate():
    def match(self, token_list):
        p.u().print("Repeat")

        p.d()
        pass

class VariableTemplate():
    def match(self, token_list):
        p.u().print("Variable")

        p.d()
        pass



def print_first_few(li):
    for idx in range(0,5):
        p.print(f"{idx}: {li.t_list[idx].type} {li.t_list[idx].value}  ")


class AnyTemplate():
    def match(self,token_list):
        p.print("ANY")
        p.u()
        print_first_few(token_list)
        p.print("sub")
        print_first_few(retype_tokens( token_list.t_list[2:]  ))
        p.d()
        if match_template_start(token_list.t_list):
        #if token_list.peek(t.BRACE_OPEN) and token_list.peek_idx(1, t.BRACE_OPEN ):
            #p.print("tok_start")
            parser_results = md_parser.parse_md.concerns.match_first(token_list.t_list[2:],
                                                [
                                                    ImportTemplate(),
                                                    ConditionTemplate(),
                                                    RepeatTemplate(),
                                                    VariableTemplate()
                                                ])
            if token_list.peek_idx(parser_results.consumed + 2, t.BRACE_CLOSE ) and token_list.peek_idx(parser_results.consumed + 2 + 1, t.BRACE_CLOSE ):
                return [True,parser_results]
            
        else:
            return [False, [] ]

class StringsAndTemplates():
    def match(self,token_list):

        pass

class StringsOnly():
    def match(self,token_list):
        return [True, token_list]
        pass


def parse_templates( token_list):
    print("parsing token list")
    tokens_left = len(token_list.t_list)

    while tokens_left != 0 :
        print(md_parser.parse_md.concerns.match_first(token_list, [
            AnyTemplate(),
            StringsAndTemplates(),
            StringsOnly()
        ])
              )
        break
        


