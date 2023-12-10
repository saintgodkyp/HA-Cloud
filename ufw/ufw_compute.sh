ufw allow 3932/tcp
ufw allow 4789/udp
ufw allow 123/udp
ufw allow 5000:5999/tcp

#https://docs.openstack.org/nova/pike/admin/default-ports.html
#ssh	3932	1g
#vxlan	4789	udp
#ntp	123	udp

#To                         Action      From
#--                         ------      ----
#[ 1] 3932/tcp                   ALLOW IN    Anywhere
#[ 2] 123/udp                    ALLOW IN    Anywhere
#[ 3] 4789/udp                   ALLOW IN    Anywhere
#[ 4] 5000:5999/tcp              ALLOW IN    Anywhere
#

