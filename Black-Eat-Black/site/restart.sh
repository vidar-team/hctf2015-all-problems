#!/bin/bash

killall -9 uwsgi
echo "" > cache/uwsgi_qazwsxedc.log
uwsgi -x uwsgi_config_qazujm.xml  -d cache/uwsgi_qazwsxedc.log
