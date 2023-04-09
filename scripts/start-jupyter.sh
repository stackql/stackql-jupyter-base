export JUPYTER_DOCKER_STACKS_QUIET=1
if [ $# -eq 0 ]
  then
    echo "no arguments supplied, starting jupyter with no token"
    start-notebook.sh --NotebookApp.token=''
else
    echo "starting jupyter with token"
    token=$1
    start-notebook.sh --NotebookApp.token='${token}'
fi