import io
import os
import sys
import re


from bs4 import BeautifulSoup as bs

pure_dir = ".org_gen/pure_posts"


def main():
    base_txt = ""
    with open(sys.argv[1]) as base_file:
        base_txt = base_file.read()

        soup = bs(base_txt, "html.parser")                #make BeautifulSoup
        base_txt = soup.prettify()   #prettify the html

    pre_body  = re.search("(.*<body>).*", base_txt,re.DOTALL)
    body      = re.search("<body>(.*)</body>", base_txt,re.DOTALL)
    post_body = re.search("(</body>.*)", base_txt,re.DOTALL)

    #print(pre_body.groups(0))
    #print("-------------------------------------")
    #print(body.groups(0))
    #print("-------------------------------------")
    #print(post_body.groups(0))

    if not os.path.exists(pure_dir):
        os.makedirs(pure_dir)
        
    with open(os.path.join(pure_dir, os.path.basename(sys.argv[1])), "w" ) as output_file:
        output_file.write(body.groups()[0])

if __name__ == "__main__":
    main()
