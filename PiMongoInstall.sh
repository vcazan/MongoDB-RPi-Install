#!/bin/bash

clear

cat << "EOF"

  __  __                              _____   ____  
 |  \/  |                            |  __ \ |  _ \ 
 | \  / |  ___   _ __    __ _   ___  | |  | || |_) |
 | |\/| | / _ \ | '_ \  / _` | / _ \ | |  | ||  _ < 
 | |  | || (_) || | | || (_| || (_) || |__| || |_) |
 |_|  |_| \___/ |_| |_| \__, | \___/ |_____/ |____/ 
                         __/ |                      

                        |___/  

EOF

echo ""
echo "Fast Installer For Raspberry Pi"
echo ""
echo "Downloading ARM MongoDB Binaries"

wget "https://googledrive.com/host/0Bx0kmUhAEPl-fk9ONXFHbmJUaElEbktoOTI5aTVLZENsVER1aURiNEFEYkJBQWF1TEFIZTg/mongodb-rpi_20140207.zip"

echo "UnZipping..."
echo ""
unzip "mongodb-rpi_20140207.zip"

echo ""
echo "Adding User..."
adduser --firstuid 100 --ingroup nogroup --shell /etc/false --disabled-password --gecos "" --no-create-home mongodb

echo ""
echo "Changing Permissions..."
cp -R mongodb-rpi/mongo /opt
chmod +x /opt/mongo/bin/*

mkdir /var/log/mongodb 
chown mongodb:nogroup /var/log/mongodb
mkdir /var/lib/mongodb
chown mongodb:nogroup /var/lib/mongodb

echo ""
echo "Copying Binary Files"
cp mongodb-rpi/debian/init.d /etc/init.d/mongod
cp mongodb-rpi/debian/mongodb.conf /etc/

ln -s /opt/mongo/bin/mongod /usr/bin/mongod
chmod u+x /etc/init.d/mongod

echo ""
echo "Starting MongoDB"
update-rc.d mongod defaults
/etc/init.d/mongod start

echo "MongoDB Installed and Started"

