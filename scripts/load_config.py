import os
import io
import sys
import re

paths = os.path
def load_config():
    #we expect to be in one folder below the main folder so..
    
    self_path =paths.abspath(sys.argv[0])
    base_path = paths.dirname(paths.dirname(self_path))

    settings={}
    if "global_config.cfg" in os.listdir(base_path):
        with open(paths.join(base_path,"global_config.cfg")) as fhandle:
        
            line_content= fhandle.readlines()
            for line in line_content:
                stripped_line = line.strip()
                if stripped_line == "" or stripped_line.startswith("#") or stripped_line.find(":")==-1:
                    pass
                else:
                    splitted=[x.strip() for x in stripped_line.split(":") ]
                    print(splitted)
                    settings[splitted[0]]=splitted[1]

    print("\nReprocess settings to remove placeholders...")
    for key in settings:
        if settings[key].find("${")!= -1:
            print("\n  adjusting",key,settings[key])
            search_result = re.findall("\$\{([^ \$]*)\}",settings[key])
            if search_result:
                print("  ",search_result)
                for replace_tag in search_result:
                    print("   replacing:",key)
                    if replace_tag == key :
                        print("\nFound a path recursion in the config file for setting the following setting,please fix it:",key)
                        return None
                    if replace_tag in settings:
                        print("     pre",settings[key])
                        settings[key]=settings[key].replace("${"+replace_tag+"}",settings[replace_tag])
                        print("     post",settings[key])
                    else:
                        print("\nThe given tag does not exist in the config file, please add or remove!","${"+replace_tag+"}")
                        return None

            
                
    print("\n\nListing all settings:\n")
    for setting in settings:
        print(setting,"   ",settings[setting])

    


load_config()