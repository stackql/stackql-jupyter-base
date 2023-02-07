auth=$1
echo "starting stackql server..."
nohup /srv/stackql/stackql --auth=$auth --pgsrv.port=5444 srv &
echo "stackql server started"
