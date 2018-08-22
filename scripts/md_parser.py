import os
import sys
import re
import string

import datetime



#file to parse
f_name = "test.md"




def check_headers(text):
    #check for hashtag at start "#"
    header = re.search("(#*) .*",line)
    print(text)
    if header != None:
        result =list(filter(None,header.groups()))
        if len(result) >0:
            print("header")
            #so which one is it ?
            if len(result[0])< 6:
                #print("<h"+str(len(result[0]))+">")
                #check if there is another one at the and
                
                result = re.search("#"*len(result[0])+" [^#]* "+"#"*len(result[0]),line)
                if result != None:
                    #is double header
                    text = re.search("#"*len(result[0])+" (.*) "+"#"*len(result[0]),text).groups()[0]
                    print(text)
                else:
                    text = re.search("#"*len(result[0])+" (.*)",text).groups()[0]
                    print(text)
                    #single header

                    



md_text = open(f_name,"r")




time= datetime.datetime.now()
for line in md_text:
    
    print(line.strip())
    string_result = check_headers(line)
print((datetime.datetime.now()-time).microseconds)
    
