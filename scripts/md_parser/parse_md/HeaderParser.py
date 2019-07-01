from parse_md.BaseParser import *
from parse_md.Node import  *
from tokenizer.TokenList import  *


class cHeaderParser(cBaseParser):
    def match(self,tokens):
       if type(tokens)==list:
          tmp = cTokenList()
          tmp.t_list = tokens
          tokens = tmp

          idx =0
          hash_count=0

          #find if there is a header
          while True:
            if tokens.peek_idx(idx,"HASH"):
                hash_count+=1
                idx+=1
            else:
                break


          if hash_count >= 1:
              if
            return cNode("HEADER"+str(hash_count),"",hash_count)
          else:
            return cNode.null()

