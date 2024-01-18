#### Alternative M2 syntax
Not need to use. But it uses by core team
Documentation [here](https://developer.adobe.com/commerce/frontend-core/ui-components/concepts/binding-syntax/).

Example:
##### Knockout native syntax:
```html
<!-- ko if: isVisible -->
    <div class="someClass">
        <!-- ko i18n: 'Some translatable message!' --><!-- /ko -->
        <span data-bind="html: content"></span>
    </div>
<!-- /ko -->
```
##### Application syntax:
```html
<if args="isVisible">
    <div class="someClass">
        <translate args="'Some translatable message!'"/>
        <span html="content"></span>
    </div>
</if>
```

#### bindings
M2 has custom bindings, docs [here](https://developer.adobe.com/commerce/frontend-core/ui-components/concepts/knockout-bindings/)
- mageInit.
The mageInit binding is an adapter for the [data-mage-init] attribute that is used to initialize jQuery widgets on the associated element.
```html
<div mageInit="{
    'Magento_Ui/js/modal/modal': {
        autoOpen: true,
        buttons: false,
        modalClass: 'modal-system-messages',
        title: 'Hello world!'
    }
}"></div>
```
It is preferable to use it instead of data-mage-init arg if you use it with components.