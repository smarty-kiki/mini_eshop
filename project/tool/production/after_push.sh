#!/bin/bash

ROOT_DIR="$(cd "$(dirname $0)" && pwd)"/../../..

ln -fs $ROOT_DIR/project/config/production/nginx/mini_eshop.conf /etc/nginx/sites-enabled/mini_eshop
/usr/sbin/service nginx reload

/bin/bash $ROOT_DIR/project/tool/dep_build.sh link
/usr/bin/php $ROOT_DIR/public/cli.php migrate:install
/usr/bin/php $ROOT_DIR/public/cli.php migrate

ln -fs $ROOT_DIR/project/config/production/supervisor/mini_eshop_queue_worker.conf /etc/supervisor/conf.d/mini_eshop_queue_worker.conf
/usr/bin/supervisorctl update
/usr/bin/supervisorctl restart mini_eshop_queue_worker:*
