### setup for new with M2
- create folder and setup app: `npm init magento-app my-app` (1)
- create folder in M2 - `mkdir src/localmodules`
  `cd src/localmodules`
- put files from first step here
- run in this folder the `BUILD_MODE=magento yarn start # or build` - it will run storefront om localhost:81 url, and build new M2 instance


### setup for existing M2
- create folder and setup app: `yarn create scandipwa-app fin-front`
- - create folder in M2 - `mkdir src/localmodules`
    `cd src/localmodules`
- copy fin-front folder here
- `odocker composer config repo.theme path src/localmodules/fin-front` - will create a local repo from custom theme in composer.json
- `odocker composer require scandipwa/fin-front` - will setup all dependencies
- `odm s:up`
- run in theme folder `BUILD_MODE=magento yarn build`
- setup new theme as main in admin panel and enjoy!

### Redis configuration (env.php):
` // settings for redis cache for Scandiweb
    'cache' => [
        'frontend' => [
            'default' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'host' => 'redis',
                    'port' => '6379',
                    'persistent' => '',
                    'database' => '0',
                    'password' => '',
                    'force_standalone' => '0',
                    'connect_retries' => '1',
                    'read_timeout' => '10',
                    'automatic_cleaning_factor' => '0',
                    'compress_data' => '1',
                    'compress_tags' => '1',
                    'compress_threshold' => '20480',
                    'compression_lib' => 'gzip'
                ],
                'id_prefix' => 'd30_'
            ],
            'page_cache' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'host' => 'redis',
                    'port' => '6379',
                    'persistent' => '',
                    'database' => '1',
                    'password' => '',
                    'compress_data' => '0'
                ],
                'id_prefix' => 'd30_'
            ]
        ],
        'graphql' => [
            'id_salt' => 'pT6PdEypQEGtwapvCBf4IhdwWEzsfK7a'
        ],
        'persisted-query' => [
            'redis' => [
                'host' => 'redis',
                'port' => '6379',
                'database' => '5',
                'scheme' => 'tcp'
            ]
        ],
        'allow_parallel_generation' => false
    ],`
- possibly enough run:
` odm setup:config:set --pq-host=redis --pq-port=6379 --pq-database=5 --pq-scheme=tcp`