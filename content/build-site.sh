script_path=$(dirname $0)
cd $script_path

echo "========================"
echo "STARTING POST GENERATION"
echo "------------------------"

emacs -Q --script build-site.el

echo""
echo "========================"
echo "START POST-PROCESSING"

for file_ in .org_gen/posts/*.html ; do
    echo "Processing \"${file_}\" "
    python post-process-post.py "${file_}" 
done;

