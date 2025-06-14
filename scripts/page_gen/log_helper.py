import colorama

class PrintHelper():
    def __init__(self):
        self.text_stack = []
        self.log_stack = []

        self.lvl = 0

    def u(self):
        self.lvl +=1
        return self

    def d(self):
        self.lvl -=1
        return self

    def print_c(self,txt,col):
        self.print(col + txt + colorama.Style.RESET_ALL )
        return self

    def print(self,txt):
        lines = txt.split("\n")

        for line in lines:
            #print(f"{self.lvl*'  '}{line}" )
            self.log_stack[-1].write(f"{self.lvl*'  '}{line}\n")
            self.text_stack[-1].append(f"{self.lvl*'  '}{line}")

        return self


    def open_log(self, file_handle):
        print(f"{colorama.Fore.GREEN} opening log level { len( self.text_stack ) + 1 } {colorama.Style.RESET_ALL}")
        self.log_stack.append(file_handle)
        self.text_stack.append([])
        return self


    def close_log(self):

        print(f"{colorama.Fore.GREEN} closing log level { len( self.text_stack ) } {colorama.Style.RESET_ALL}")
        self.log_stack[-1].close()
        self.log_stack.pop()
        self.text_stack.pop()
        print(f"log size: {len(self.text_stack )  }")
        return self

    def print_stack(self):
        for line in self.text_stack[-1]:
            print(f"{line}" )
        pass

p = PrintHelper()

