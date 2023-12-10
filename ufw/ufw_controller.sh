ufw allow from 10.0.8.0/24 to any port 3306 proto tcp
ufw allow from 10.0.8.0/24 to any port 4567 proto tcp
ufw allow from 10.0.8.0/24 to any port 5672 proto tcp
ufw allow from 10.0.8.0/24 to any port 25672 proto tcp
ufw allow from 10.0.8.0/24 to any port 11211 proto tcp
ufw allow from 10.0.8.0/24 to any port 8774 proto tcp
ufw allow from 10.0.8.0/24 to any port 8775 proto tcp
ufw allow from 10.0.8.0/24 to any port 9696 proto tcp
ufw allow from 10.0.8.0/24 to any port 2224 proto tcp
ufw allow from 10.0.8.0/24 to any port 5405 proto tcp
ufw allow from 10.0.8.0/24 to any port 5000 proto tcp
ufw allow from 10.0.8.0/24 to any port 9292 proto tcp
ufw allow from 10.0.8.0/24 to any port 8778 proto tcp
ufw allow from 10.0.8.0/24 to any port 7788 proto tcp

ufw allow from 10.0.8.0/24 to any port 4789 proto udp
ufw allow from 10.0.8.0/24 to any port 4444 proto tcp
ufw allow from 10.0.8.0/24 to any port 4568 proto tcp

ufw allow from 10.0.8.0/24 to any port 8472 proto udp

ufw allow 3932/tcp
ufw allow 6080/tcp
ufw allow 80/tcp
ufw allow 443/tcp

ufw allow 123/udp

#mysql	3306	
#galera	4567	
#rabbitmq	5672	
#rabbitmq	25672	
#memcached	11211	
#nova	8774	
#nova_metadata	8775	
#neutron	9696	
#pacemaker	2224	
#corosync	5405	
#keystone	5000	
#glance-api	9292	
#placement-api	8778	
#drbd	7788	
#nova_vnc	6080	1g, 10g
#horizon	80	1g
#horizon	443	1g
#ssh	3932	1g
#vxlan	4789	udp
#vxlan	8472	udp
#ntp	123	udp

#To                         Action      From
#--                         ------      ----
#3306/tcp                   ALLOW       10.0.8.0/24               
#4567/tcp                   ALLOW       10.0.8.0/24               
#5672/tcp                   ALLOW       10.0.8.0/24               
#25672/tcp                  ALLOW       10.0.8.0/24               
#11211/tcp                  ALLOW       10.0.8.0/24               
#8774/tcp                   ALLOW       10.0.8.0/24               
#8775/tcp                   ALLOW       10.0.8.0/24               
#9696/tcp                   ALLOW       10.0.8.0/24               
#2224/tcp                   ALLOW       10.0.8.0/24               
#5405/tcp                   ALLOW       10.0.8.0/24               
#5000/tcp                   ALLOW       10.0.8.0/24               
#9292/tcp                   ALLOW       10.0.8.0/24               
#8778/tcp                   ALLOW       10.0.8.0/24               
#7788/tcp                   ALLOW       10.0.8.0/24               
#3932/tcp                   ALLOW       Anywhere                  
#4789/udp                   ALLOW       Anywhere                  
#123/udp                    ALLOW       Anywhere                  
#6080/tcp                   ALLOW       Anywhere                  
#80/tcp                     ALLOW       Anywhere                  
#443/tcp                    ALLOW       Anywhere                  
#4789/udp                   ALLOW       10.0.8.0/24               
#8472/udp                   ALLOW       10.0.8.0/24               
#4789/udp                   ALLOW       203.254.143.0/24          
#8472/udp                   ALLOW       203.254.143.0/24          

