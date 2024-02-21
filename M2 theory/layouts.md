default_head_blocks.xml can use for adding scripts or other instruction into the head. But it is your choice
in Magento_Theme module in default.xml the first row is:
```xml
<update handle="default_head_blocks"/>
    <body>
        <attribute name="id" value="html-body"/>
...
```

- if we set to container htmlTag we need to set also or htmlClass or htmlId
- If inside of container - blocks not return content - container also will not rendered even if it has class and tag 
- we can skip the name of block it will generate for us, but we cant use it
- default + specific handle. Specific goes after so has more priority than a default
- get all layouts (handles) implemented to current page (in phtml) - `$block->getLayout()->getUpdate()->getHandles()` 
- but previous instruction wont show handles that was added directly by `update handle` from other layouts
- for product page we also have handle by type, id and sku - catalog_product_view_sku_test123, by SKU most priority
- for category the same by type (layered) and id
- for cms by id, where id it is string (home for example)
- URN generation - odm dev:urn-catalog:generate .idea/misc.xml
- `<container name="content" as="content" label="Main Content Area"/>` container with label can be uses by user from admin panel to input custom content, fro example to put widget into this container 
- $block->getVar(varName, moduleName) - get vars from the view.xml, for example - `$block->getVar('gallery/nav', 'Magento_Catalog')`
- if block or container has alias - we cant invoke (render) them by name, for example: `$block->getChildHtml(blockName)`, only by alias in this case
- use cms block in layout:
```xml
 <block class="Magento\Cms\Block\Block" name="megamenu.banner.block">
    <arguments>
        <argument name="block_id" xsi:type="string">megamenu_banners-block</argument>
    </arguments>
</block>
```
- we can put blocks to a certain group (in layout), and in phtml gathered all those blocks by `$block->getGroupSortedChildNames('detailed_info', '$block->getGroupSortedChildNames('detailed_info', 'getChildHtml')')`
- the second param it is call back that will be invoked on each block (getChildHtml or just getHtml)