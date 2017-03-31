

## Setting up mosquitto on rpi

TO READ: https://learn.adafruit.com/mqtt-adafruit-io-and-you/intro-to-adafruit-mqtt?view=all

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install mosquitto mosquitto-clients python-mosquitto
```


## /etc/mosquitto/conf.d/mosquitto.conf

```
# Config file for mosquitto
#
# See mosquitto.conf(5) for more information.
 
user mosquitto
max_queued_messages 200
message_size_limit 0
allow_zero_length_clientid true
allow_duplicate_messages false
 
listener 1883
autosave_interval 900
autosave_on_changes false
persistence true
persistence_file mosquitto.db
allow_anonymous true
password_file /etc/mosquitto/passwd
```

```
$ sudo systemctl restart mosquitto
$ sudo mosquitto_passwd -c /etc/mosquitto/passwd mosquitto
>> password

$ sudo /etc/init.d/mosquitto status -l
``
