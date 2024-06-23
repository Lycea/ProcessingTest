import re
import os
import sys
#import imp


# Get the path of the directory containing the current script
current_script_dir = os.path.dirname(os.path.abspath(__file__))

# Calculate the paths to the directories containing 'parse_md' and 'scripts'
parse_md_dir = os.path.join(current_script_dir,"..", "md_parser")
scripts_dir = os.path.join(current_script_dir,"..","..", "scripts")

# Add these directories to sys.path temporarily
sys.path.insert(0, parse_md_dir)
sys.path.insert(0, scripts_dir)



import md_parser.tokenizer.TokenList as TokenList
import md_parser.parse_md.concerns as concerns

import tokens
import grammers


pjoin = os.path.join

t = tokens.toks


#############
# local print settings
############

enable_tok_debug = False
enable_post_process_debug = False

##########
## tokenization
##########
class Token:
    def __init__(self, type_="NONE", value_="NONE"):
        self.type = type_
        self.value = value_

        if enable_tok_debug:
            print("\nTYPE:",self.type)
            print("VALUE:",self.value)
            print("len:",len(self.value))

    #create an end of file token
    @staticmethod
    def end_of_file():
        #print("end of file")
        return Token("EOF","")

    #not a token :P
    @staticmethod
    def null():
        return False

    def getSize(self):
        return len(self.value)
import datetime

class TemplateFunctions:
    @staticmethod
    def repeat(x, amount):
        return str(x) * (amount)

    @staticmethod
    def gen_time():
        return datetime.datetime.now().strftime("%d/%m/%Y, %H:%M:%S")
        

depths_max = 10
cur_depth = 0

class TemplateParser:
    def __init__(self):
        self.__base_text = ""
        self.__template_path = ""
        self.__parsed_templates ={}
        #self.__token_list = TokenList.cTokenList()

    def set_text(self, txt):
        self.__base_text = txt
        return self

    def set_template_path(self, template_path):
        self.__template_path = template_path
        return self

    def replace_template(self, argument_list):
        template_path = pjoin(self.__template_path, argument_list[0])

        if template_path in self.__parsed_templates:
            return self.__parsed_templates[template_path]

        print("searched template:", template_path)
        if os.path.exists(template_path):
            with open(template_path) as template_file:
                template_text = template_file.read()
                print(template_text)
                replaced_text = self.find_and_replace_templates(text=template_text)
                self.__parsed_templates[template_path] = replaced_text

                return replaced_text

        else:
            print(f"ERROR: TEMPLATE NOT FOUND:\n  {template_path}")
            exit(-1)


    def find_and_replace_templates_(self,text=""):
        output_text = self.__base_text

        if text != "":
            output_text = text

        template_strings = re.findall("{{(.*)}}", output_text)

        if len(template_strings) > 0:
            print(f"Found {len(template_strings)} templates")

            for template in template_strings:
                splitted_template = template.split(":")
                generation_type = splitted_template[0]
                generation_args = splitted_template[1:]

                if generation_type == "TEMPLATE":
                    replace_txt = self.replace_template(generation_args)
                    output_text=output_text.replace("{{" +template + "}}", replace_txt)
        return output_text


#-----------------------------
# NEW CLEAN VARIATION
#---

#--------
# tokking
    def preproc_strings(self,tokens):
        processed = []
        
        proc_string =""
        is_processing = False

        print("----------------------")
        print("POST_PROCESSING_STRINGS")

        for token in tokens:
            if token.type == "CHAR" and is_processing:
                proc_string+=token.value
            elif token.type == "CHAR":
                is_processing=True
                proc_string+=token.value

            elif token.type != "CHAR" and is_processing:
                is_processing = False
                processed.append(Token("STRING", proc_string))

                proc_string = ""
                processed.append(token)
            else:
                processed.append(token)

        if enable_post_process_debug:
            print("\n-------------------")
            print("DEBUG LIST OUTPUT ~")
            for token in processed:
                print(token.type,token.value)

        return processed


    def preproc_spaces(self, tokens):
        processed = []

        proc_spaces = ""
        is_processing = False

        print("----------------------")
        print("POST_PROCESSING_SPACES")
        #print(tokens)
        for token in tokens:
            if token.type == "SPACE" and is_processing:
                proc_spaces+=token.value

            elif token.type == "SPACE":
                is_processing=True
                proc_spaces+=token.value

            elif token.type != "SPACE" and is_processing:
                is_processing = False
                processed.append(Token("SPACE", proc_spaces))

                proc_spaces = ""
                processed.append(token)
            else:
                processed.append(token)

        if enable_post_process_debug:
            print("\n-------------------")
            print("DEBUG LIST OUTPUT ~")
            for token in processed:
                print(token.name,token.value)
        print("------------------")        
        return processed



    def tok_template(self, txt):
        tokenized = TokenList.cTokenList()

        for char in txt :
            tokenized.add(Token(tokens.tok_alias.get(char,tokens.tok_alias["default"])  ,char) )

        tokenized.t_list = self.preproc_spaces(self.preproc_strings(tokenized.t_list))
        
        return tokenized
#-------
# parsing / lexing

    def parse_templates(self, tokens):
        pass

    def build_parse_tree(self):
        # tmpl_idx= self.__base_text.find("{{", last_idx)

        # if tmpl_idx != -1:
        #     tokens_ =self.tok_template(self.__base_text[tmpl_idx:])

        #     grammers.parse_templates(tokens_)
        global cur_depth
        tokens_ = self.tok_template(self.__base_text)
        results  = grammers.parse_templates(tokens_)

        nodes_ = results[1]

        if results[0]== False:
            print("FAILED PARSING THE TEMPLATE")
            return False

        full_text = ""
        print("checking / parsing nodes")
        for node in nodes_:
            print("node type:",node.type)
            match node.type:
                case "TEXT":
                    full_text+= node.value

                case "FUNCTION":
                    grammers.p.print("PARSING_FUNCTION")
                    #p.print("PARSING FUNCTION")
                    grammers.p.print(node.name)
                    grammers.p.print(str(node.parameters))

                    pure_param =[]
                    for parameter in node.parameters:
                        if parameter.sub_type == "VARIABLE":
                            grammers.p.print(f"VARS: {self.__variables}")
                            grammers.p.print(f"VAR NAME: {parameter.value}")
                            if parameter.value in self.__variables:
                                grammers.p.print("VARIABLE FOUND")
                                pure_param.append(self.__variables[parameter.value])
                            else:
                                grammers.p.print_c(f"VARIABLE NOT FOUND: {parameter.value}", grammers.colorama.Fore.RED)
                                return False
                        else:
                            parameter.value = parameter.value.replace('"',"")
                            pure_param.append(parameter.value)

                    if node.name in dir(TemplateFunctions):
                        call = getattr(TemplateFunctions, node.name)
                        full_text += call(*pure_param)

                case "IMPORT":
                    print("PARSING IMPORT",node.path)
                    #full_text+="\nIMPORT\n"
                    full_tmp_path = os.path.join(self.__template_path, node.path)
                    if os.path.exists(full_tmp_path):
                        if cur_depth >= depths_max:
                            print("MAX DEPTHS REACHED ... STOPPING")
                            return False

                        cur_depth+=1
                        sub_parser = TemplateParser()

                        sub_parser.set_template_path(self.__template_path)
                        txt = ""
                        with open(full_tmp_path,"r") as fi:
                            txt=fi.read()

                            sub_parser.set_variables(self.__variables)
                        sub_parser.set_text(txt)
                        result = sub_parser.find_and_replace_templates()
                        
                        if result == False:
                            print("ERROR WHILE PARSING SUBPAGE: "+node.path)
                            return False
                        else:
                            full_text+=result
                    else:
                        print("TEMPLATE PATH DOES NOT EXIST")


            # if node.type == "TEXT":
            #     full_text+= node.value
            # if node.type == "IMPORT":
            #     full_text+="\nTEMPLATE\n"

            #     sub_parsing =TemplateParser()
        #exit()
        return full_text


    def find_and_replace_templates(self, text=""):
       parse_tree = self.build_parse_tree()
       return parse_tree



    def set_variables(self, variables):
        self.__variables = variables
        return self








