#### Locale disabled from admin
For production the general/locale/code node config is disabled (lock) for production env. Code is:
`vendor/magento/module-backend/etc/adminhtml/di.xml`
```xml
    <type name="Magento\Config\Model\Config\Structure\ElementVisibility\ConcealInProductionWithoutScdOnDemand">
        <arguments>
            <argument name="configs" xsi:type="array">
                <item name="general/locale/code" xsi:type="const">Magento\Config\Model\Config\Structure\ElementVisibilityInterface::DISABLED</item>
            </argument>
        </arguments>
    </type>
```
So, to set this value for all instance we can use config.php:
```php
// as default
 'default' => [ 
            'general' => [
                'locale' => [
                    'code' => 'en_AU'
                ]
            ],
        ],
        // website level
  'websites' => [
            'w_dusk_nz' => [
                'general' => [
                    'locale' => [
                        'code' => 'en_NZ'
                    ]
                ]
            ]
        ]
    ],
    // also we can set for admin
    'admin_user' => [
        'locale' => [
            'code' => [
                'en_US'
            ]
        ]
    ]
```

the CLI command - `php -f bin/magento config:set general/locale/code 'en_AU' --lock-env` - will set this setting to env.php (useful for cloud)
the `php bin/magento app:config:dump system general` - will dump to config.php all system/general section and lock it for admin

#### Static content deploy for specific locale (language)
`php bin/magento setup:static-content:deploy --theme Dusk/default en_NZ`

#### Cloud locale configuration
needs to add to .magento.env.yaml the SCD_MATRIX node with all languages:
```yaml
stage:
  global:
    SKIP_HTML_MINIFICATION: true
    ENABLE_EVENTING: true
    SCD_MATRIX:
      "Dusk/default":
        language:
          - en_AU
          - en_NZ
```