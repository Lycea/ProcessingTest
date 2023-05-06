import os
import sys




def create_page_tree(tree,path_base,depth=0,base=""):
    print("base:"+path_base)
    tree["name"]=os.path.basename(path_base)
    tree["has_info"]=False

    found_dirs = False
    for item in sorted(os.listdir(path_base)):
        deeper_path = os.path.join(path_base,item)
        
        
        if os.path.isdir(deeper_path)==True:
            tree[item]={"has_child":True,"is_sketch":False}
            print(depth*"  "+"In sub tree..")
            print(depth*"  "+str(tree))
            create_page_tree(tree[item],deeper_path,depth+1,base)
            print("")

            found_dirs =True
        else:
            if item.find(os.path.basename(path_base))!=-1 and deeper_path.endswith(".html"):
                tree["is_sketch"]= True
                tree["path"]=deeper_path.replace(base,"")
                print(depth*"  "+"Found sketch")
                print(depth*"  "+str(tree))


    if not found_dirs:
        tree["has_child"]=False

    print(depth*"  "+str(tree)+"\n")
    
         

    

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
                    txt= process_page_tree(tree[key],txt,depth+1,True)

                    txt+=depth*"  "+"</div>\n"
                else:
                    txt+=depth*"  "+"<"+header_str+" class='collaps_title'>"+key+"</"+header_str+">\n<div class='content_div'>"
                    txt= process_page_tree(tree[key],txt,depth+1,True)

                    txt+=depth*"  "+"</div>\n"
            elif tree[key]["has_child"]and tree[key]["is_sketch"]:
                pass
            elif not tree[key]["has_child"]and tree[key]["is_sketch"] and tree[key]["path"][-4:]=="html" :
                
                #print(tree[key]["path"])
                
                if is_child:
                    txt+=depth*"  "
                    txt+='<a class="norm" href="'+tree[key]["path"]+'" >'+tree[key]["name"]+'</a></br>'
                    txt+="\n"
                else:
                    txt+=depth*"  "+'<p class="sketch_item">'
                    txt+='<a class="norm" href="'+tree[key]["path"]+'" >'+tree[key]["name"]+'</a>'
                    txt+="</p>\n"
    
            
            
    print(txt)
    return txt


def generate_list(preview=False):
    create_preview_list = preview


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


    
    template_file = open("../templates/html_files/style_default","r")
    base_text = template_file.read()

    template_file.close()

    list_text = "<p>\n"



    list_text = """
            <style>
            .collaps_title {
                          background-color: #777;
                          color: white;
                          cursor: pointer;
                          padding: 18px;
                          width: 100%;
                          border: none;
                          text-align: left;
                          outline: none;
                          font-size: 15px;
                        }

              .active, .collaps_title:hover {
                          background-color: #555;
                        }

              .content_div {
                          padding: 0 18px;
                          display: none;
                          overflow: hidden;
                          background-color: #f1f1f1;
                        }
            </style>
            <p>Here you find an overview of all created sketches: </p>"""+list_text
    list_text = '<div class="content">'+list_text
    count = 0
    #find all sketches

    sketch_tree={}
    

    for item in os.listdir(sketch_path):
        print("i am here: ",sketch_path,item)
        deeper_path = os.path.join(sketch_path,item)
        
        if os.path.isdir(deeper_path)==True:
            sketch_tree[item]={"has_child":True,"is_sketch":False}
            create_page_tree(sketch_tree[item],deeper_path,0,sketch_path+os.path.sep)
    
    if len(sketch_tree.keys())>4:
        list_text=process_page_tree(sketch_tree,list_text)


     


    list_text+="</p>"
    list_text+="</div>"

    list_text+="""\n\n\n<script type='text/javascript'>
                  var coll = document.getElementsByClassName("collaps_title");
                  var i;

                  for (i = 0; i < coll.length; i++) {
                    coll[i].addEventListener("click", function() {
                      this.classList.toggle("active");
                      var content = this.nextElementSibling;
                      if (content.style.display === "block") {
                        content.style.display = "none";
                      } else {
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