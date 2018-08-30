import os
import sys
import re
import string

import datetime



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


token_checker = cTokenizer()
token_checker.setMdText("Hello _world_\nThis *is* me")
token_checker.start()

for token in token_checker.tokens:
    print(token.value+" "+token.type)


#info websites
#https://spec.commonmark.org/0.26/
##tutorial
#https://blog.beezwax.net/2017/07/07/writing-a-markdown-compiler/