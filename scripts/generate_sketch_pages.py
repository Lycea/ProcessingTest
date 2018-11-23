import os
import datetime

sketch_name = "RandomWalkRGB"






path = ""
#generate folder
if not os.path.exists("../sketches/"+sketch_name):
    os.mkdir("../sketches/"+sketch_name)
    path ="../sketches/"+sketch_name
else:
    time = datetime.datetime.now()
    time_string = "../sketches/"+sketch_name+"_"+str(time.year)+"_"+str(time.month)+"_"+str(time.day)+"_"+str(time.hour)+"_"+str(time.minute)
    print(time_string)
    os.mkdir(time_string)
    path = time_string

#generate pde file based on template

#load in the template
temp_f = open("../templates/pde_files/basic","r")
temp_txt = temp_f.read()
temp_f.close()

#write it to the pde file
script = open(path+"/"+sketch_name+".pde","w")
script.write(temp_txt)
script.close()


#generate html file based on template
temp_f = open("../templates/html_files/pde_start_file","r")

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