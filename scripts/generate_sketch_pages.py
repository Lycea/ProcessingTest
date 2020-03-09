import os
import datetime
import sys



sketch_base ="./../sketches/"
def create_page(name):
    sketch_name = name


    path = ""
    #generate folders recursuveky
    if not os.path.exists(sketch_base+sketch_name):

        sketch_name.replace("\\","/")


        res =sketch_name.split("/")
        
        for idx in range(len(res)+1):
            
            print(os.path.join(sketch_base,"/".join(res[:idx])))
            if not os.path.exists(os.path.join(sketch_base,"/".join(res[:idx]))):
                os.mkdir(os.path.join(sketch_base,"/".join(res[:idx])))
                path = os.path.join(sketch_base,"/".join(res[:idx]))
                pass
        sketch_name=res[-1]
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
    #check all lines and add script line for inclusion of script
    for line in temp_f:
        tmp_txt.append(line.strip())
        if line.find("<body>")!=-1:
            tmp_txt.append('<script src="'+sketch_name+".pde"+'" ></script>')

    temp_f.close()

    html  = open(path+"/"+sketch_name+".html","w")
    html.write("\n".join(tmp_txt))
    html.close()



if __name__ == "__main__":
    if len(sys.argv)>1:
        sketch_name =sys.argv[1]
        create_page(sketch_name)
    else:
        print("Please enter a name for the new sketch!")
        exit()