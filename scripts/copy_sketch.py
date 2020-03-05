import os
import datetime
import sys
import shutil
import argparse


def list_sketch_names():
    sketches = os.listdir("./../sketches")
    for sketch in sorted(sketches):
        print(sketch)
    pass


def copy_page(name,new_name):
    path = ""
    old_path = "./../sketches/"+name

    if not os.path.exists(old_path):
        print("The sketch you selected to copy doees not exist! ",name,"Path:",old_path)
        exit()

    
    #generate folder
    if not os.path.exists("./../sketches/"+new_name):
        os.mkdir("./../sketches/"+new_name)
        path ="./../sketches/"+new_name
    else:
        time = datetime.datetime.now()
        time_string = "./../sketches/"+new_name+"_"+str(time.year)+"_"+str(time.month)+"_"+str(time.day)+"_"+str(time.hour)+"_"+str(time.minute)
        print(time_string)
        os.mkdir(time_string)
        path = time_string

   

    #load in the old sketch
    temp_f = open(old_path+"/"+name+".pde","r")
    temp_txt = temp_f.read()
    temp_f.close()

    #write it to the pde file
    script = open(path+"/"+new_name+".pde","w")
    script.write(temp_txt)
    script.close()


    #generate html file based on template
    temp_f = open("./../templates/html_files/pde_start_file","r")

    tmp_txt=[]
    #check all lines and add script line for inclusion of script
    for line in temp_f:
        tmp_txt.append(line.strip())
        if line.find("<body>")!=-1:
            tmp_txt.append('<script src="'+new_name+".pde"+'" ></script>')

    temp_f.close()

    html  = open(path+"/"+new_name+".html","w")
    html.write("\n".join(tmp_txt))
    html.close()



if __name__ == "__main__":

    parser =argparse.ArgumentParser()
    parser.add_argument("original_sketch_name",help="Name of the script which should be be copied",action="store")
    parser.add_argument("copy_sketch_name",help="The new Name which the scetch should have after copying",action="store")
    parser.add_argument("--list_all",help="Lists all available sketches",action="store_true",default=False,required=False)

    parser_output=parser.parse_args()

    if parser_output.list_all == True:
        print("Only listing all available sketches!")
        list_sketch_names()
    else:
        copy_page(parser_output.original_sketch_name,parser_output.copy_sketch_name)
 


    exit()