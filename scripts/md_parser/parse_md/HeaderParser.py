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
          while True:
            if tokens.peek_idx(idx,"HASH"):
                hash_count+=1
                idx+=1
            else:
                break

        return cNode("HEADER")

          return cNode.null()