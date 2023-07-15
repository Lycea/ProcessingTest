import yaml, pprint

def check_yaml(yaml_file="../../generator.yaml"):
    print("start checking yaml...")
    try:
        with open(yaml_file) as fin :
            config = yaml.safe_load(fin)
            pprint.pprint(config)
    except Exception as e:
        print("Got an error while checking yaml:")
        return False

    return True

if __name__ == "__main__":
    print("starting standalone ~")
    if check_yaml() == True :
        exit(0)
    else:
        exit(-1)
