from tokenizer.token import *
from tokenizer.BaseScanner import *


class cHeaderScanner(cScanner):
    def from_string(self, raw_text):
        text = raw_text
        txt_token = ""
        # iterate the string

        for char in text:
            # if it is not a token
            if char == "#":
                txt_token+="#"
            else:
                break
        # check if has no content else return
        if txt_token == "" or len(txt_token)>6:
            return cToken.null()
        else:
            return cToken("HEADER", txt_token)
