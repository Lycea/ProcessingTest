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

          tmp_val = ""
          if hash_count >= 1:
            print("---------------")
            print("parsing header")
            print("---------------")
            while idx<tokens.count():
                print(tokens.peek_idx(idx+1,"NEWLINE"),tokens.getValueAt(idx))
                
                if tokens.peek_idx(idx,"NEWLINE"):
                    break
                else:
                    tmp_val +=tokens.getValueAt(idx+1)
                    hash_count+=1
                    idx+=1
            

            print("end value:",tmp_val)
            print("parsing end")
            print("------------")
            return cNode("HEADER"+str( min(hash_count,5)),tmp_val,hash_count)
          else:
            return cNode.null()

