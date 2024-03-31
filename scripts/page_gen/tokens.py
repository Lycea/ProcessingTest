tok_alias ={}
tok_alias["{"] = "BRACE_OPEN"
tok_alias["}"] = "BRACE_CLOSE"
tok_alias["."] = "POINT"
tok_alias["default"] = "CHAR"
tok_alias[" "] = "SPACE"
tok_alias['"'] = "STRING_START_END"
tok_alias['('] = "FUNCT_OPEN"
tok_alias[')'] = "FUNCT_CLOSE"
tok_alias["="] = "EQUAL_SIGN"
tok_alias[">"] = "BIGER"
tok_alias["<"] = "SMALLER"
tok_alias["!"] = "NOT"
tok_alias[","] = "COMMA"
tok_alias[":"] = "COLON"
tok_alias["/"] = "SLASH"
tok_alias["\n"] = "SPACE"

class toks():
    BRACE_OPEN = "BRACE_OPEN"
    BRACE_CLOSE = "BRACE_CLOSE"
    POINT = "POINT"
    STRING = "STRING"
    SPACE = "SPACE"
    STRING_START_END = "STRING_START_END"
    FUNCT_OPEN = "FUNCT_OPEN"
    FUNCT_CLOSE = "FUNCT_CLOSE"
    EQUAL_SIGN = "EQUAL_SIGN"
    BIGER = "BIGER"
    SMALLER = "SMALLER"
    NOT = "NOT"
    COMMA = "COMMA"
    COLON = "COLON"
    SLASH = "SLASH"

    TEMPLATE_OPEN = [BRACE_OPEN, BRACE_OPEN]
    TEMPLATE_CLOSE = [BRACE_CLOSE, BRACE_CLOSE]

