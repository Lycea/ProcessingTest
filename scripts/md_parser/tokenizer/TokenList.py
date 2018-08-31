class cTokenList():
    def __init__(self):
        self.t_list = []

    #add an item to the list
    def add(self,item):
        self.t_list.append(item)

    #checks the first index and tells if yes or no
    def peek(self,type_):
        if self.t_list[0].type == type_:
            return True
        else:
            return False
        
    def peek_idx(self,idx,type_):
        try:
            if self.t_list[idx].type == type_:
                return True
            else:
                return False
        except Exception as e:
            print("No item left in queu")
            return False

    #expects a list and a list in the list
    # [[TYPE1,TYPE2,TYPE3,TYPE4],[TYPE1,TYPE2,TYPE4]]
    #[UNDERSCORE,TEXT,UNDERSCORE],[STAR,TEXT,STAR]
    def peek_or(self,list):
        count_consumed = 0
        matches = True

        #iterate the different lists for checking
        for rule_list in list:
            count_consumed = 0
            matches = True

            #check if the whole case fits
            for type in rule_list:
                if self.peek_idx(count_consumed,type):
                    count_consumed += 1 
                    continue
                else:
                    #one part doesn't fit so no fit for that case
                    matches = False
                    break
            #check if it was a success or not
            if matches == False:
                #well no finding here continue
                count_consumed = 0
                continue
            else:
                #found matches so break here and tell it is a fit
                break

        #return if there was a match or not
        return [matches,count_consumed]
    
    def print_list(self):
        for token in self.t_list:
            print(token.type+"  "+token.value)
    
    #get value from index  but starting from 1 so calc -1
    def getValueAt(self,idx):
        return self.t_list[idx-1].value

    def count(self):
        return len(self.t_list)


#test cases to check if the class works as expected
if __name__ == "__main__":
   from token import *
   to_list = cTokenList()

   to_list.add(cToken("UNDERSCORE","_"))
   to_list.add(cToken("TEXT","I'm some text"))
   to_list.add(cToken("UNDERSCORE","_"))
   
   if to_list.peek("UNDERSCORE")==True:
       print("Seccessfull checked test , first item is an Underscore")
   else:
       print("Failed teset , first item is an Underscore")

   if to_list.peek_or([["UNDERSCORE","UNDERSCORE","UNDERSCORE"],["UNDERSCORE","TEXT","UNDERSCORE"]])[0]==True:
       print("It found the match, good")
   else:
       print("It didn't find a match , even though there is one")
    
