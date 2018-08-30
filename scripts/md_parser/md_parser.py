import os
import sys
import re
import string

import datetime


print(sys.version)
#file to parse
f_name = "test.md"



parsable_text = "A text section __with__ some *deco*"
samples=[
    "_test*",
    "__bold__",
    "*emphazized*"
]
#more compiler like way ? (sample)




from tokenizer.tokenizer import *
from parser.parser import *


token_checker = cTokenizer()
token_checker.setMdText("Hello _world_\n\nThis *is* me")
token_checker.start()


token_checker.tokens.print_list()

md_parser = cParser()
md_parser.parse(token_checker.tokens)



#for token in token_checker.tokens:
#    print(token.value+" "+token.type)


#info websites
#https://spec.commonmark.org/0.26/
##tutorial
#https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/