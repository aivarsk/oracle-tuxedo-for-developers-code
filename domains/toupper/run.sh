export PATH=$TUXDIR/bin:$PATH
export LD_LIBRARY_PATH=$TUXDIR/lib:$LD_LIBRARY_PATH
export TUXCONFIG=`pwd`/tuxconfig
export BDMCONFIG=`pwd`/bdmconfig

cat ubbconfig.in \
| sed s:@TUXDIR@:$TUXDIR:g \
| sed s:@UNAME@:`uname -n`:g \
| sed s:@CURDIR@:`pwd`:g > ubbconfig

tmloadcf -y ubbconfig
dmloadcf -y dmconfig
echo crdl -z `pwd`/tlog -b 200 | tmadmin
echo crlog -m tuxapp | tmadmin
tmboot -y
bash
tmshutdown -y
