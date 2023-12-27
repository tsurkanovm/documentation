### 1. text/x-magento-init
Used with a JSON object to load modules and initialize them with server-generated configuration:
```
<div id="digits-render-block" data-bind="scope: 'digitsComponent'">
    <!-- ko template: getTemplate() --><!--/ko-->
</div>
<script type="text/x-magento-init">
    <script type="text/x-magento-init">
    {
        "*": {
            "Overdose_ProductBanners/js/banner_config": {
                "productItemSelector": "<?php echo $helper->getProductItemSelector(); ?>",
                "selectorToHide": "<?php echo $helper->getSelectorToHide(); ?>"
            }
        }
    }
</script>
```
### 2. data-mage-init attribute 
Instantiates a Javascript module with any provided configuration for the current tag:
``` <form class="form form-login" data-mage-init='{"validation":{}}'> ```
The same as above (1) (in the case with selector), but use some tags.

### 3. Just inject plain JS to phtml 
(<script … require([])).
Bad practice.

### 4. Also you can add scripts from admin (Design)
not recommended, only for clients.

### 5. In default_head_blocks.xml 
but ut is for all pages.