function include(file)
{ 
    console.log(file)
    let script = document.createElement('script');
    script.src = file;
 
    document.getElementsByTagName('head').item(0).appendChild(script)
}

function load()
{
    var disp_param= (new URLSearchParams(window.location.search)).get("display")

    var scripts = document.getElementsByTagName("script"),
    src = scripts[scripts.length-1].src;

    console.log("checking param")
    if (disp_param != null)
    {
        console.log("display ?")
        //include("../../../libs/helpers/sketch_settings_display.js") 
        include(
            src.replace("setting_loader.js",  "sketch_settings_display.js")) 
    }
    else
    {
        
        //include("../../../libs/helpers/sketch_settings_base.js") 
        include(src.replace("setting_loader.js",
                            "sketch_settings_base.js")
        ) 
    }

}

load()