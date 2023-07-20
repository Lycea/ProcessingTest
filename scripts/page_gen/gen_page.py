import yaml
import shutil
import os
import re
import check_yaml

pjoin = os.path.join

base_path = "../.."

config = None
config_path = os.path.join(base_path, "generator.yaml")
generatin_base_path = os.path.join( base_path,"generated")
template_base_path = ""

parsed_templates = {}

def load_yaml():
    with open(config_path) as yaml_handle:
        config = yaml.safe_load(yaml_handle)
    return config

def check_base_config(config):
    if not config.get("config"):
        print("No config object found...")
        return False
    return True


def replace_template(argument_list):
    template_path = pjoin(template_base_path, argument_list[0])

    if template_path in parsed_templates:
        return parsed_templates[template_path]

    print(template_path)
    if os.path.exists(template_path):
        with open(template_path) as template_file:
            template_text = template_file.read()
            replaced_text = find_and_process_templates(template_text)
            parsed_templates[template_path] = replaced_text

            return replaced_text

    else:
        print(f"ERROR: TEMPLATE NOT FOUND:\n  {template_path}")
        exit(-1)


def find_and_process_templates(text):
    template_strings = re.findall("{{(.*)}}", text)

    if len(template_strings) > 0:
        print(f"Found {len(template_strings)} templates")

        for template in template_strings:
            splitted_template = template.split(":")
            generation_type = splitted_template[0]
            generation_args = splitted_template[1:]

            if generation_type == "TEMPLATE":
                replace_txt = replace_template(generation_args)
                text=text.replace("{{" +template + "}}", replace_txt)
    return text


def generate_page(template_path):
    global template_base_path
    template_base_path = pjoin(base_path, config["config"]["options"].get("template_location","templates"))

    output_path = pjoin(generatin_base_path, template_path+".html")

    with open(pjoin(template_base_path, template_path)) as template_file:
        base_text = template_file.read()
        print(base_text)

        output_text = find_and_process_templates(base_text)
        print("---------------------")
        print(output_text)

        with open(output_path, "w") as out_file:
            out_file.write(output_text)
        

def start_generation():
    global config
    #first of change the working directory to this folder, to make life easier...
    os.chdir( os.path.dirname(__file__))

    #first check the yaml existence / validity
    if check_yaml.check_yaml() == False:
        print("Yaml is not valid / does not exist, check config")
        exit(-1)
    
    config = load_yaml()
    if not check_base_config(config):
        exit(-1)

    if config["config"]["options"].get("generate_all"):
        print("generate all pages anew")

    if config["config"]["options"].get("generate_all") and os.path.exists(generatin_base_path):
        shutil.rmtree(generatin_base_path)

    if not os.path.exists(generatin_base_path):
        os.makedirs(generatin_base_path)

    if config["config"].get("direct_copy_folders"):
        for folder in config["config"].get("direct_copy_folders"):
            print(f"Moving folder {folder} ...")
            shutil.copytree( pjoin(base_path, folder), pjoin(generatin_base_path, folder))

    if config["config"].get("direct_copy_files"):
        for file in config["config"].get("direct_copy_files"):
            print(f"Moving files {file} ...")
            shutil.copy( pjoin(base_path, file) , pjoin(generatin_base_path, file))

    generate_page(config["config"]["options"].get("start_template", "default"))

start_generation()
