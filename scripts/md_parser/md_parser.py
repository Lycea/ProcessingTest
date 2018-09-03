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
from parse_md.parser import *
from generate_md.generator import *




token_checker = cTokenizer()
token_checker.setMdText("Hello this is a md test\n\n This __bold__ and this is **bold**\n\nThis is _italic_ and this is *italic*")
token_checker.start()


token_checker.tokens.print_list()

md_parser = cParser()
tree = md_parser.parse(token_checker.tokens)
print(tree)
md_generator =cGenerator()



html =md_generator.generate(tree)
print(html)

#f=open("test.html","w")
#f.write(html)
#f.close()




#info websites
#https://spec.commonmark.org/0.26/
##tutorial
#https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/