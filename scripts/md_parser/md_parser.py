import os
import sys
import re
import string

import datetime


print(sys.version)


#Testcases
test_text ="Hello this is a md test\nThis is __bold__ and \nthis is **bold**\n\nThis is _italic_ and this is *italic*"
samples=[
    "__bold__",
     "**bold**",
    "*emphazized*",
    "_emphazized_",
    "~striked~",
    "___both___"
]



from tokenizer.tokenizer import *
from parse_md.parser import *
from generate_md.generator import *


def parse_md(raw_md_text):
    token_checker = cTokenizer()
    md_parser = cParser()
    md_generator =cGenerator()

    token_checker.setMdText(raw_md_text)
    token_checker.start()
    #token_checker.tokens.print_list()
    
    tree = md_parser.parse(token_checker.tokens)
    
    html =md_generator.generate(tree)
    print(html)





parse_md(test_text)

for sample in samples:
    parse_md(sample)

#info websites
#https://spec.commonmark.org/0.26/
##tutorial
#https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/