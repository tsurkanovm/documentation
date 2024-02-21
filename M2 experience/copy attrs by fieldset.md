Looks like you need to define maps into fieldset.xml file and it should works automatically. But it is not.

For example fieldset.xml:
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="urn:magento:framework:DataObject/etc/fieldset.xsd">
    <scope id="global">
        <fieldset id="sales_convert_quote">
            <field name="dusk_rewards">
                <aspect name="to_order" />
            </field>
        </fieldset>
        <fieldset id="quote_convert_item">
            <field name="dusk_rewards">
                <aspect name="to_order_item" />
            </field>
        </fieldset>
    </scope>
</config>
```
Copy from quote item to order item will work only if we have this attribute in OrderItemInterface. And it will convert automatically
For copy from quote to order needs to create observer on sales_model_service_quote_submit_before event and use the next:
```php
/* @var $this->objectCopyService Magento\Framework\DataObject\Copy **/
$this->objectCopyService->copyFieldsetToTarget('sales_convert_quote', 'to_order', $quote, $order);
```
So we can define a map (in fieldset.xml) of coping and use copyFieldsetToTarget service. Attributes can be from different entities 