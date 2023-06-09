#!/bin/python3
import os
import datetime
import sys



sketch_base ="./../sketches/"
def create_page(name):
    sketch_name = name
    lib_path=""
    css_path=""

    path = ""
    #generate folders recursuveky
    if not os.path.exists(os.path.join(sketch_base, sketch_name)):

        #if we are working here with os.oath.join and os.path.sep then
        #this should not matter anymore
        #non the less TODO: check on windows(real windows)
        #sketch_name.replace("\\","/")
        print("full name:",sketch_name)
        res = sketch_name.split(os.path.sep)

        lib_path = "../" * (len(res)+1)
        css_path = "../" * len(res)

        print("[DEBUG] sketch depths: ", len(res))
        print("[DEBUG] lib_path:", lib_path)
        print("[DEBUG] css_path:", css_path)

        os.makedirs(os.path.join(sketch_base, sketch_name))
        path = os.path.join(sketch_base,sketch_name)

        sketch_name=res[-1]

        print("Pure name:",sketch_name)
        print("")
    else:
        time = datetime.datetime.now()
        time_string = sketch_base+sketch_name+"_"+str(time.year)+"_"+str(time.month)+"_"+str(time.day)+"_"+str(time.hour)+"_"+str(time.minute)
        print(time_string)
        os.mkdir(time_string)
        path = time_string
    #generate pde file based on template

    #load in the template
    temp_f = open("./../templates/pde_files/basic","r")
    temp_txt = temp_f.read()
    temp_f.close()

    #write it to the pde file
    script = open(path+"/"+sketch_name+".pde","w")
    script.write(temp_txt)
    script.close()


    #generate html file based on template
    temp_f = open("./../templates/html_files/pde_start_file","r")

    tmp_txt=[]
    #TODO check what that specifically does
    #check all lines and add script line for inclusion of script
    for line in temp_f:
        tmp_txt.append(line.strip())
        if line.find("<body>")!=-1:
            tmp_txt.append('<script src="'+sketch_name+".pde"+'" ></script>')

    temp_f.close()
    full_text = "\n".join(tmp_txt)
    full_text = full_text.replace("{PATH_LIB}", lib_path[:-1])
    full_text = full_text.replace("{PATH_CSS}", css_path[:-1])

    html  = open(path + "/" + sketch_name + ".html", "w")

    html.write(full_text)
    html.close()



if __name__ == "__main__":
    if len(sys.argv)>1:
        sketch_name =sys.argv[1]
        create_page(sketch_name)
    else:
        print("Please enter a name for the new sketch!")
        exit()
