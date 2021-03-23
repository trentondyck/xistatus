# How to use, server side
#
```bash
install nginx (whatever distro) python3, pip3
yum install nginx -y
cd /var/www/html
git clone xistatus
mv xistatus/* .
python3 -m venv .
source xistatus_env/bin/activate
pip3 install requirements.txt
python manage.py makemigrations status
python manage.py migrate
python manage.py runserver &
service nginx start
```

# How to use, client side
#
create a folder under windower4/addons called xistatus
copy xistatus.lua into that folder
add 'lua load xistatus' to windower4/scripts/init.txt

# Webapp development resources
#
```bash
django-admin startproject xistatus .
python manage.py startapp frontend
python manage.py startapp status
python manage.py makemigrations status
python manage.py migrate
python manage.py runserver &
https://ehmatthes.github.io/pcc/
https://www.youtube.com/watch?v=TmsD8QExZ84
https://www.youtube.com/watch?v=hISSGMafzvU
```

# xistatus plugin resources
#
https://www.reddit.com/r/ffximodding/comments/9ndg2d/complete_list_of_zone_dats_by_zone_id/
https://github.com/lorand-ffxi/OhNoYouDont/blob/master/OhNoYouDont.lua
https://console.cloud.google.com/compute/instances?project=silver-origin-308313&instancessize=50
https://freedns.afraid.org/subdomain/
https://github.com/Windower/Lua/wiki/Events
https://github.com/Windower/Lua/wiki/FFXI-Functions

