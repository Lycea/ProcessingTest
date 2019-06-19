from git import Repo
import os
import sys
import io

from datetime import datetime

def diff_size(diff):
    """
    Computes the size of the diff by comparing the size of the blobs.
    """
    if diff.b_blob is None and diff.deleted_file:
        # This is a deletion, so return negative the size of the original.
        return diff.a_blob.size * -1

    if diff.a_blob is None and diff.new_file:
        # This is a new file, so return the size of the new value.
        return diff.b_blob.size

    # Otherwise just return the size a-b
    return diff.a_blob.size - diff.b_blob.size


def diff_type(diff):
    """
    Determines the type of the diff by looking at the diff flags.
    """
    if diff.renamed: return 'R'
    if diff.deleted_file: return 'A'
    if diff.new_file: return 'D'
    return 'M'




def get_all_sketches():
    sketches_paths ={}
    for root,folders,files in os.walk("./../sketches"):  
        for folder in folders :
            sketches_paths["sketches/"+folder] = {"name":folder}
    return sketches_paths
            






sketches_info = get_all_sketches()



EMPTY_TREE_SHA   = "4b825dc642cb6eb9a060e54bf8d69288fbee4904"
DATE_TIME_FORMAT = "%Y-%m-%dT%H:%M:%S%z"

path =   os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
print(path)

test_repo =Repo("./../")

commits = [c for c in test_repo.iter_commits()]

#commits.reverse()

for commit in commits:
    parent = commit.parents[0] if commit.parents else EMPTY_TREE_SHA
    #print(commit.message)

    diffs  = {
        diff.a_path: diff for diff in commit.diff(parent)
    }
    for objpath,stats in commit.stats.files.items():
        diff = diffs.get(objpath)
        if not diff:
            for diff in diffs.values():
                if diff.b_path == objpath and diff.renamed:
                    break
        
        

        stats.update({
            'object': os.path.join(path, objpath),
            'commit': commit.hexsha,
            'author': commit.author.email,
            'timestamp': commit.authored_datetime.strftime(DATE_TIME_FORMAT),
            'size': diff_size(diff),
            'type': diff_type(diff),
        })


        if stats.get("type")=="A" and os.path.dirname(objpath) in sketches_info.keys():
            print(objpath+"  "+stats.get("type"))

            time = datetime.fromtimestamp(  commit.committed_date)
            time_str = time.strftime("%Y-%m-%d")
            sketches_info[os.path.dirname(objpath)]["date_added"]=time_str



for sketch in sketches_info:
    print(sketches_info[sketch])

#head = test_repo.head
#master = head.reference

#log =master.log

#for log_ in log:
#    print(log_)
