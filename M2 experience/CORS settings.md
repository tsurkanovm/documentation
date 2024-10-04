In my React instance I tried to get some data from my M2 instance and get the next error, 
Or - Ever try to work with the Magento GraphQL API or REST API from your browser and see the following -
"Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at http://fin.local/rest/V1/digits/best"

Needs to setup this module - https://github.com/graycoreio/magento2-cors
 and add to env.php
 ```php
  'system' => [
        // CORS PERMISSIONS
        'default' => [
            'web' => [
                'graphql' => [
                    'cors_allowed_origins' => 'http://localhost:5173',
                    'cors_allowed_methods' => 'POST, OPTIONS,PUT,GET,DELETE',
                    'cors_allowed_headers' => 'Content-Currency, Store, X-Magento-Cache-Id, X-Captcha, Content-Type, Authorization, DNT, TE',
                    'cors_max_age' => '86400',
                    'cors_allow_credentials' => 5
                ],
                'api_rest' => [
                    'cors_allowed_origins' => 'http://localhost:5173',
                    'cors_allowed_methods' => 'GET, POST, OPTIONS, DELETE, PUT',
                    'cors_allowed_headers' => 'Content-Currency, Store, X-Magento-Cache-Id, X-Captcha, Content-Type, Authorization, DNT, TE',
                    'cors_max_age' => '86400',
                    'cors_allow_credentials' => 5
                ]
            ]
        ],
 ```