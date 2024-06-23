import time
import colorama

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

    def print_c(self,txt,col):
        self.print(col + txt + colorama.Style.RESET_ALL )
        return self

    def print(self,txt):
        lines = txt.split("\n")
        for line in lines:
            print(f"{self.lvl*'  '}{line}" )

        return self


p = PrintHelper()

#fix token list problem ...
def retype_tokens(tokens):
    if type(tokens) == type([]):
        tmp = TokenList.cTokenList()
        tmp.t_list = tokens
        return tmp
    else:
        return tokens


def print_first_few(li):
    for idx in range(0,5):
        p.print(f"{idx}: {li.t_list[idx].type} {li.t_list[idx].value}  ")


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
                    print(matched[0][0])
                    #ret = cNode("ImportTemplate","",res[1]+matched[1] )

                    ret = nodes.cImportTemplate(matched[0][0].value)
                    ret.consumed = res[1] + matched[1]
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


        p.d()
        return False

class RepeatTemplate():
    def match(self, token_list):
        p.u().print("Repeat")

        p.d()
        return False



def tok_till(tokens,exept_list):
    tokens = retype_tokens(tokens)
    count=0

    while tokens.t_list[count].type not in exept_list:
        p.print(tokens.t_list[count].type)
        count+=1
    return [count,tokens.t_list[count].type]


#we know at least it could be a function so try pierce stuff together
def get_function_parts(tokens):
    p.u().print("")
    p.print("Function,params,Search")
    ret = cNode.null()

    token_list = retype_tokens(tokens)
    print_first_few(token_list)
    count = 0
    param_list = []

    next_allowed={
        t.FUNCT_OPEN: [t.STRING_START_END,t.STRING,t.FUNCT_CLOSE],
        t.COMMA: [t.STRING_START_END,t.STRING],
        t.STRING: [t.COMMA, t.FUNCT_CLOSE],
        t.STRING_START_END: [t.COMMA, t.FUNCT_CLOSE]
    }
    if token_list.t_list[0].type == t.SPACE:
        count += 1

    continue_parsing = True
    valid = True
    prev_type = t.FUNCT_OPEN
    

    while continue_parsing :
        print_first_few(retype_tokens(token_list.t_list[count:]))
        cur_type = token_list.t_list[count].type

        #handle spaces...
        if cur_type == t.SPACE:
            p.print("..space handling")
            count+=1
            cur_type = token_list.t_list[count].type
        
        p.print(f"{cur_type} {prev_type}")
        #check validity of the current type...
        if cur_type not in next_allowed[prev_type]:
            continue_parsing = False
            valid = False
            break
        
        #should be a simple variable
        if cur_type == t.STRING:
            #param_list.append(token_list.t_list[count])
            subtype="VARIABLE"
            if token_list.t_list[count].value.isdecimal():
                subtype="NUMBER"
            p.print(f"VALUE: {token_list.t_list[count].value}")
            param_list.append(nodes.cParameter(subtype,token_list.t_list[count].value,1))
            count+=1
            p.print("Simple value")

        #is a string literal
        elif cur_type == t.STRING_START_END:
            p.print("Some string literal")
            string_info = tok_till(token_list.t_list[count+1:],[t.STRING_START_END,t.TEMPLATE_OPEN,t.TEMPLATE_CLOSE])
            p.print(str(string_info))

            if string_info[1] == t.STRING_START_END:
                param_tokens  = token_list.t_list[count:count+string_info[0]+2]
                param_string = ""
                for token in param_tokens:
                    param_string+=token.value
                p.print(f"VALUE:{param_string}")

                param_list.append(nodes.cParameter("STRING_LITERAL", param_string,len(param_tokens)))
                count+=string_info[0] +2
            #Something else broke the string which is not supported as of now
            else:
                p.print("String literal end was unexpected")
                valid = False
                continue_parsing = False
                break

        #is a funciton close, which is fine to be here
        elif cur_type == t.FUNCT_CLOSE:
            valid = True
            continue_parsing = False
            count+=1
        #Comma
        elif cur_type == t.COMMA:
            count+=1
        #found some other symbol that should not be here
        else:
            continue_parsing = False
            valid = False
        
        prev_type = cur_type
        p.print("------")
    p.print(str(param_list)+str(valid))

    if valid:
        ret = [True,param_list,count]
    else:
        ret = [False]
    return ret

   

class VariableTemplate():

    def match(self, token_list):
        ret = False

        p.u().print_c("Variable",colorama.Fore.CYAN)
        p.u()
        token_list = retype_tokens(token_list)
        print_first_few(token_list)

        consumed = 0
        if token_list.t_list[0].type==t.SPACE:
            consumed +=1
            token_list.t_list = token_list.t_list[1:]


        res= token_list.peek_or(
            [
#                 [t.STRING,t.SPACE,t.BRACE_CLOSE],
#                 [t.STRING,t.BRACE_CLOSE],
#                 #variable sets#
#                 # < SET >  <var> <val>
#                 [t.STRING,t.SPACE,t.STRING,t.SPACE,t.STRING,t.SPACE ,t.BRACE_CLOSE],
#                 [t.STRING,t.SPACE,t.STRING,t.SPACE,t.STRING,t.BRACE_CLOSE]
                #normal variables
                [t.STRING,t.SPACE,t.BRACE_CLOSE],
                [t.STRING,t.BRACE_CLOSE],
                #variable sets#
                # < SET >  <var> <val>
                [t.STRING,t.SPACE,t.STRING,t.SPACE,t.STRING,t.SPACE ,t.BRACE_CLOSE],
                [t.STRING,t.SPACE,t.STRING,t.SPACE,t.STRING,t.BRACE_CLOSE]
            ]
        )


        print(res)

        if res[0]:
            print(f"size: {res[1]}")
        else:
            
            #check if we got a funciton
            res = token_list.peek_or(
                [
                    [t.STRING,t.FUNCT_OPEN]
                ]
            )
            if res[0]:
                print("IS A FUNCTION PROBABLY!")

                parts = get_function_parts(token_list.t_list[2:])
                print("PARTS",parts)

                if parts[0]:
                    ret = nodes.cFunction()
                    ret.parameters = parts[1]
                    ret.consumed = parts[2] +2
                    ret.name = token_list.t_list[0].value
        p.d()
#        exit()
        return ret



class AnyTemplate():
    def match(self,token_list):
        p.print(colorama.Fore.CYAN + "ANY TEMPLATE" + colorama.Style.RESET_ALL)
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
            
            offset = 2 # offset based of the two start brackets
            if parser_results == False :
                return False

            print("results",parser_results)
            print("results",parser_results.consumed)


            if token_list.t_list[parser_results.consumed +offset].type == t.SPACE:
                offset+=1
                p.print("found space before template end")

            print_first_few(retype_tokens(token_list.t_list[parser_results.consumed +offset:]))
            #if token_list.peek_idx(parser_results.consumed , t.BRACE_CLOSE ) and token_list.peek_idx(parser_results.consumed + 2 + 1, t.BRACE_CLOSE )
            if match_template_end(token_list.t_list[parser_results.consumed + offset:]):
                p.print("end_found")
                parser_results.consumed += offset +2
                return parser_results
            else:
                p.print("NO END FOUND")
                return False
            
        else:
            return False


class StringsTillTmpStart():
    def match(self,token_list):
        p.print_c("STRING (till template)", colorama.Fore.CYAN )
        ret = False

        consumed = 0
        value = ""

        for idx in range(0, len(token_list.t_list)):
            # print(idx)
            if not match_template_start(token_list.t_list[consumed:consumed +5]):
                consumed+=1
                value+= token_list.getValueAt(idx + 1)
            else:
                break
        if consumed > 0:
            ret = cNode("TEXT", value, consumed)
        return ret
        

class StringsTillTmpEnd():
    def match(self,token_list):
        p.print_c("STRING (till template)", colorama.Fore.CYAN )

        ret = False
        return ret


def parse_templates( token_list):
    print("parsing token list")
    tokens_left = len(token_list.t_list)
    parse_successfull = False

    parsed_nodes =[]
    round_num = 0

    while tokens_left != 0 :
        round_num+=1
        print(f"PARSING ROUND: {round_num} ;TOKENS {tokens_left}")
        p.print_c("\nNEXT PARSING ROUND", colorama.Fore.YELLOW)
        ret = md_parser.parse_md.concerns.match_first(token_list, [
            AnyTemplate(),
            StringsTillTmpStart()
        ])

        if ret != False:
            p.print("tmp_parse_result:  "+str(ret)+" cons: "+str(ret.consumed)  )
            tokens_left -= ret.consumed
            token_list= retype_tokens(token_list.t_list[ret.consumed:])
            parsed_nodes.append(ret)

        else:
            p.print_c("COULD NOT PARSE TEMPLATE",colorama.Fore.RED)
            parsed_nodes=[]
            break

        if tokens_left == 0:
            p.print_c("SUCCESSFULL PARSE", colorama.Fore.GREEN)
            p.print(f"Found {len(parsed_nodes)} nodes")
            p.u()
            for node in parsed_nodes:
                p.print(str(node))
            p.d()
            parse_successfull = True

    return [ parse_successfull ,parsed_nodes]
