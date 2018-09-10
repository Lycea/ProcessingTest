import os
import sys

create_preview_list = False


#find the complete way to the script directory
dir_path = os.path.dirname(os.path.realpath(__file__))
#print(dir_path)

#find the importent directories
base_path = dir_path[:dir_path.rfind("/")]
sketch_path = base_path+"/sketches"
#print(base_path)
#print(sketch_path)

#create the sketch overview page
sketch_list =open(sketch_path+"/sketch_list.html","w")

sketch_list.write("<body>")
sketch_list.write("<ul>\n")


count = 0
#find all sketches
for root,dirs,files in os.walk(sketch_path):
    for dir in dirs:
        if create_preview_list == False:
            #add them as link
            count +=1 
            sketch_list.write("\t<li>")
            sketch_list.write('<a href="'+dir+'/'+dir+'.html'+'">'+dir+'</a>')
            sketch_list.write("</li>\n")
        else:
            count +=1
            #header line
            sketch_list.write("\t<h3>")
            sketch_list.write('<a href="'+dir+'/'+dir+'.html'+'">'+dir+':</a>')
            sketch_list.write("</h3>\n")
            sketch_list.write('<object data="'+dir+'/'+dir+'.html'+'" type="text/html" width = "500px" height="450px" style="overflow:hidden; min-width: 101%; min-height: 101%"></object>')
            


sketch_list.write("</ul>")
sketch_list.write("</body>")
sketch_list.close()


print("Added list with "+str(count)+" linked sketches")