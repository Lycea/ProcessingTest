import yaml
import shutil
import os

import check_yaml

pjoin = os.path.join

base_path = "../.."

config = None
config_path = os.path.join(base_path, "generator.yaml")
generatin_base_path = os.path.join( base_path,"generated")


def load_yaml():
    with open(config_path) as yaml_handle:
        config = yaml.safe_load(yaml_handle)
    return config

def check_base_config(config):
    if not config.get("config"):
        print("No config object found...")
        return False
    return True


def start_generation():
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


start_generation()
