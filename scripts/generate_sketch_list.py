import os
import sys

create_preview_list = False


#find the complete way to the script directory
dir_path = os.path.dirname(os.path.realpath(__file__))
#print(dir_path)

#find the importent directories
base_path = dir_path[:dir_path.rfind(os.sep)]

sketch_path = os.path.join(base_path,"sketches")
#print(base_path)
#print(sketch_path)

#create the sketch overview page
sketch_list =open(os.path.join(sketch_path,"sketch_list.html"),"w")



template_file = open("./../templates/html_files/style_default","r")
base_text = template_file.read()

template_file.close()

list_text = "<ul>\n"



list_text = "<p>Here you find an overview of all created sketches: </p>"+list_text
list_text = '<div class="content">'+list_text
count = 0
#find all sketches
for root,dirs,files in os.walk(sketch_path):
    for dir in sorted(dirs):
        if create_preview_list == False:
            #add them as link
            count +=1 
            list_text+='\t<li class="norm">'
            list_text+='<a class="norm" href="'+dir+'/'+dir+'.html'+'">'+dir+'</a>'
            list_text+="</li>\n"

        else:
            count +=1
            #header line
            list_text+="\t<h3>"
            list_text+='<a class="norm" href="'+dir+'/'+dir+'.html'+'">'+dir+':</a>'
            list_text+="</h3>\n"
            list_text+='<object data="'+dir+'/'+dir+'.html'+'" type="text/html" width = "500px" height="450px" style="overflow:hidden; min-width: 101%; min-height: 101%"></object>'
            


list_text+="</ul>"
list_text+="</div>"

#replace placeholders
base_text = base_text.replace("{PATH_TO_CSS}","../style.css")
base_text = base_text.replace("{CONTENT_OF_PAGE}",list_text)
base_text = base_text.replace("{PATH_HOME}","../index.html")
base_text = base_text.replace("{PATH_SKETCHES}","../sketches/sketch_list.html")

sketch_list.write(base_text)
sketch_list.close()


print("Added list with "+str(count)+" linked sketches")