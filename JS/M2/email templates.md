[Link](https://developer.adobe.com/commerce/frontend-core/guide/templates/email/)

#### overriding
Override email templates by creating templates in a new directory in your custom theme, using this pattern: 
``<theme_dir>/<ModuleVendorName>_<ModuleName>/email``

#### variables
- System variables are placeholders which are replaced by particular values when the actual email is generated. 
For example, the Store Hours ``({{config path="general/store_information/hours"}})``
- Custom variables. You may also create your own custom variables and set their values in the Admin, under SYSTEM > Other Settings > Custom Variables.
- Template-specific vars. The selection of available variables depends on which template you use as a basis. 
The template-specific variables are contained in a <!--@vars @--> comment at the top of each template on the file system. 


#### Styles
- inline:
``{{inlinecss file="css/email-inline.css"}}``
The inlinecss directive tells the application which files to apply as inline styles on the email template.
- Global non-inline styles
  While the majority of styles should be applied inline, there are certain CSS styles that cannot be applied inline, such as media queries or :hover pseudo styles. 
These styles must be in a <style type="text/css"></style> tag for them to work.
```
<style type="text/css">
    {{var template_styles|raw}}

    {{css file="css/email.css"}}
</style>
```
The css directive compiles the contents of the provided file and outputs it.
For example, say an email is being sent from a store configured with the Luma theme. 
The css directive first looks for an email.less file in <Magento_Luma_theme_dir>/web/css. 
However, because the file does not exist there, it falls back to <Magento_Blank_theme_dir>/web/css/email.less. 
The contents of that file are compiled and its contents output in the <style> tag.

- Template-specific non-inline styles
  As mentioned in the preceding section, the header.html file outputs the {{var template_styles|raw}} variable.
The value of that variable comes from any of the following:
Any styles you add to any html email template inside a comment block, like in the following example, are included in the template_styles variable:
```
 <!--@styles
   .example-style { color: green; }
 @-->
```
It is just documentation (for readable proporses), not defining:
```html
<!--@vars {
"var logo_url":"Email Logo Image URL",
"var logo_alt":"Email Logo Alt Text",
...
} @-->
```
All specific vars prepared and send separately:
```php
$vars = [
            'store' => $this->_storeManager->getStore($this->getStoreId()),
            'subscriber_data' => [
                'confirmation_link' => $this->getConfirmationLink(),
            ],
        ];
        $this->sendEmail(self::XML_PATH_CONFIRM_EMAIL_TEMPLATE, self::XML_PATH_CONFIRM_EMAIL_IDENTITY, $vars);

```

Here core logic for global vars (from config mostly) - `vendor/magento/module-email/Model/AbstractTemplate.php`

- {{var variable_name}}:

  This is used to display variables that are passed directly to the template when the email or page is being generated.
  These variables are often dynamic and depend on the context, such as order details in an order confirmation email ({{var order.getCustomerName()}}) or store information ({{var store.name}}).
  They are typically set in the code when preparing the template's content, like in a custom module or in the core Magento code that handles sending emails or generating pages.

- {{customVar code=variable_code}}:
This is specifically for custom variables that you define in the Magento Admin under System > Custom Variables.
- trans
```<p>{{trans "My store name - %store_name," store_name=$store.name}}</p>```