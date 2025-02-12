### Context
The GraphQL [front controller](https://github.com/magento/magento2/blob/2.4.5/app/code/Magento/GraphQl/Controller/GraphQl.php#L194) creates an instance of Magento\GraphQl\Model\Query\ContextInterface before the request is ever passed off for processing.
Various modules inject "context processor" classes into Magento\GraphQl\Model\Query\ContextFactory to modify the context object that is ultimately created. These include the Magento_StoreGraphQl module, which adds information about the store view context, and the Magento_CustomerGraphQl module, which adds information about the user. 
```xml
 <type name="Magento\GraphQl\Model\Query\ContextFactory">
        <arguments>
            <argument name="contextParametersProcessors" xsi:type="array">
                <item name="add_store_info_to_context" xsi:type="object">Magento\StoreGraphQl\Model\Context\AddStoreInfoToContext</item>
            </argument>
        </arguments>
    </type>
```
Here are examples of how to access common pieces of context information from within a resolver:
```php
$context->getUserId(); // Gets the customer ID
$context->getExtensionAttributes()->getStore(); // Gets the full store model 
$context->getExtensionAttributes()->getCustomerGroupId(); // Gets the customer's group ID
```
In order to add some other dimension of context information needed by GraphQL, the required steps would be:
- Add an attribute to Magento\GraphQl\Model\Query\ContextInterface with extension_attributes.xml.
- Create a class implementing Magento\GraphQl\Model\Query\ContextParametersProcessorInterface to add the data with addExtensionAttribute.
- Inject your processor class as an item in the contextParametersProcessors argument of Magento\GraphQl\Model\Query\ContextFactory. This is usually done specifically in graphql/di.xml.

### Authorization
If a GraphQL request is sent with a valid PHPSESSID cookie, this will indeed authenticate the user and make that user context available. This is not the method we really want to rely on for authorization in GraphQL.
Session cookies can be disabled with:
`bin/magento config:set graphql/session/disable 1`
Magento supports both admin and customer tokens. While admin tokens can be sent with GraphQL requests, there is not actually a GraphQL mutation available for generating one (GraphQL queries and mutations being centered around front-end experience). The REST authentication endpoint would need to be used such a token.
However, we've already seen the appropriate mutation for generating a customer token:
```graphql
mutation generateToken($email: String!, $password: String!) {
    generateCustomerToken(
        email: $email
        password: $password
    ) {
        token
    }
}
```
