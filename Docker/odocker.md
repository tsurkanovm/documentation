### Installation

Link to [documentation](https://overdosedigital.atlassian.net/wiki/spaces/ODMagento/pages/3121381460/ODocker+V2+Tool+installation).

Pay Attention:
If you have changed the Odocker mode parameter then:

1. you must remove config files for projects by path: <project_dir>/.odocker/configs/*.yml
2. you need to re-init odocker by command: odocker re-build

/home/mihail/.config/composer/vendor/overdose/odocker/ - here scripts

Your Odocker been initialized, your config file there: /home/mihail/.overdose/odocker/data/.env
(odocker version, php version, mysql user+pass)
.overdose/odocker/data/config/nginx/magento.nginx.conf

Fixes for uses common ports:
`sudo service mysql stop`
`sudo service apache2 stop`
New project setup: `odocker setup-project`
Exist project up - `odocker start`
New M2 (clear) project setup - `odocker new-prject-setup`

Shared containers:

- Maria DB
- Nginx (app)
- Redis
- Elastic (optional)

Specific containers for each project (configured in <project>/.odocker/config.env):

- PHP
- Composer
- Node

After .env changes - `odocker re-build -a`, or remove yaml - in this way start command will rebuild
`odocker re-build -p` - rebuilds only project specific containers

View all commands - `odocker`

Nginx logs - docker logs <container id>, nginx - it is docker-compose-app

sudo service apache2 stop && odocker start

admin-user=odocker
admin-password=odocker123

odocker mysql -p globewest(DB name) -e "Show tables";

### Mailhog

it is build by default (or check - this service should be enabled),
so only needs to rewrite config - `.config/composer/vendor/overdose/odocker/config/configs/php/msmtprc`
And setup config accordingly in admin (host - mailhog and port - 1025)~~~~
web interface is - http://0.0.0.0:8025
