import os
import sys




def create_page_tree(tree,path_base, depth=0, base=""):
    if depth == 0:
        print(" ")
    print( (depth*3*" ") + "base:",path_base)
    tree["name"]     = os.path.basename(path_base)
    tree["has_info"] = False

    found_dirs = False
    for item in sorted(os.listdir(path_base)):
        deeper_path = os.path.join(path_base,item)

        #there are some subpackages there
        if os.path.isdir(deeper_path)==True:
            tree[item]={"has_child":True,"is_sketch":False}
            print((depth*3*" ") +"In sub tree..")
            #print((depth*3*" ") +str(tree))
            create_page_tree(tree[item],deeper_path,depth+1,base)
            print("")

            found_dirs =True
        else:
            if item.find(os.path.basename(path_base))!=-1 and deeper_path.endswith(".html"):
                tree["is_sketch"]= True
                tree["path"]=deeper_path.replace(base,"")
                print("\n", (depth*3*" ") +"Found sketch")
                for k in tree:
                    print("  ",(depth*3*" "),k,tree[k])


    if not found_dirs:
        tree["has_child"]=False

    #print(depth*"  "+str(tree)+"\n")
    
def process_page_tree(tree,txt,depth=0,is_child=False):
    black_list =["is_sketch","name","has_child","has_info","path"]
    for key in sorted(tree.keys()):
        if key not in black_list:
            header_level = max(1,min(depth+3,7))
            header_str   = "div"#"h"+str(header_level)
            print(key)

            if tree[key]["has_child"] and not tree[key]["is_sketch"]:
                if is_child:
                    txt+=depth*"  "+"<"+header_str+" class='collaps_title'>"+key+"</"+header_str+">\n<div class='content_div'>"
                    txt= "\n"+process_page_tree(tree[key],txt,depth+1,True)
                    txt+=depth*"  "+"</div>\n"
                else:
                    txt+=depth*"  "+"<"+header_str+" class='collaps_title'>"+key+"</"+header_str+">\n<div class='content_div'>"
                    txt="\n" +process_page_tree(tree[key],txt,depth+1,True)

                    txt+=depth*"  "+"</div>\n"
            elif tree[key]["has_child"]and tree[key]["is_sketch"]:
                pass
            elif not tree[key]["has_child"]and tree[key]["is_sketch"] and tree[key]["path"][-4:]=="html" :
                if is_child:
                    #txt+=depth*"  "
                    #txt+='<a class="norm" href="'+tree[key]["path"]+'" >'+tree[key]["name"]+'</a></br>'
                    #txt+="\n"

                    txt+=depth*"  "+'<div class="sketch_item">'
                    txt+='<a class="norm" href="'+tree[key]["path"]+'" >'+tree[key]["name"]+'</a>'
                    txt+="</div>\n"

                else:
                    txt+=depth*"  "+'<div class="sketch_item">'
                    txt+='<a class="norm" href="'+tree[key]["path"]+'" >'+tree[key]["name"]+'</a>'
                    txt+="</div>\n"
    
    print(txt)
    return txt


def generate_list(preview=False):
    create_preview_list = preview

    #find the complete way to the script directory
    dir_path = os.path.dirname(os.path.realpath(__file__))
    base_path = os.path.split(dir_path)[0]
    #base_path = dir_path[:dir_path.rfind(os.sep)]

    sketch_path = os.path.join(base_path,"sketches")

    #create the sketch overview page
    sketch_list =open(os.path.join(sketch_path,"sketch_list.html"),"w")

    template_file = open("../templates/html_files/style_default","r")
    base_text = template_file.read()

    template_file.close()

    list_text = "<p>\n"

    list_text = """
            <p>Here you find an overview of all created sketches: </p>"""+list_text
    list_text = '<div class="content">'+list_text
    count = 0
    #find all sketches
    sketch_tree={}
    
    print("start checking for sketches ...")
    for item in os.listdir(sketch_path):
        print("  checking dir : ",sketch_path,item)
        deeper_path = os.path.join(sketch_path,item)
        
        if os.path.isdir(deeper_path)==True:
            sketch_tree[item]={
                "has_child":True,
                "is_sketch":False
            }
            create_page_tree(sketch_tree[item], deeper_path, 0, sketch_path+os.path.sep)

    #TODO Find out why there is a magic 4 ...  it is the amount of sketches found , maybe some old leftovers ?
    if len(sketch_tree.keys())>4:
            
        print("\n\ngenerating sketch list")
        print("  key length ?",len(sketch_tree.keys()))
        list_text=process_page_tree(sketch_tree,list_text)

    
    list_text+="</p>"
    list_text+="</div>"

    list_text+="""\n\n\n<script type='text/javascript'>
                  var coll = document.getElementsByClassName("collaps_title");
                  var i;

                  coll.textContent+= "v"

                  for (i = 0; i < coll.length; i++)
                  {
                    coll[i].addEventListener("click", function()
                    {
                      this.classList.toggle("active");
                      var content = this.nextElementSibling;

                      if(content.style.display === "block")
                      {
                        console.log("switching to none")
                        content.style.display = "none";

                        this.contentText = this.base_text
                      }
                      else
                      {
                        this.base_test = this.contentText
                        this.contentText = "v" + this.contentText
                        content.style.display = "block";
                      }
                    });
                  }
                </script>\n\n\n
                """

    #replace placeholders
    base_text = base_text.replace("{PATH_TO_CSS}","../style.css")
    base_text = base_text.replace("{CONTENT_OF_PAGE}",list_text)
    base_text = base_text.replace("{PATH_HOME}","../index.html")
    base_text = base_text.replace("{PATH_SKETCHES}","../sketches/sketch_list.html")

    sketch_list.write(base_text)
    sketch_list.close()

    print("Added list with "+str(count)+" linked sketches")



if __name__ == "__main__":
    generate_list(False)
