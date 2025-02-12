### Recursive or async resolvers
If resolver need to resolve sub-field (product has website field that has own resolver). 
And we want to do this in one query (in other way it will be for every product) - resolver should use callback and value Factory:
- vendor/magento/framework/GraphQl/Query/Resolver/ValueFactory.php
```php
 $result = function () use ($value, $context, $productDataProvider) {
            $data = $value['product'] ?? $productDataProvider->getProductBySku($value['sku'], $context);
            if (empty($data)) {
                return null;
            }
            if (!isset($data['model'])) {
                throw new LocalizedException(__('"model" value should be specified'));
            }
            $productModel = $data['model'];
            /** @var \Magento\Catalog\Model\Product $productModel */
            $data = $productModel->getData();
            $data['model'] = $productModel;
            if (!empty($productModel->getCustomAttributes())) {
                foreach ($productModel->getCustomAttributes() as $customAttribute) {
                    if (!isset($data[$customAttribute->getAttributeCode()])) {
                        $data[$customAttribute->getAttributeCode()] = $customAttribute->getValue();
                    }
                }
            }
            return array_replace($value, $data);
        };
        return $this->valueFactory->create($result);
```

Another option is to implement _Magento\Framework\GraphQl\Query\Resolver\BatchResolverInterface_ instead of the typical resolver interface.
With BatchResolverInterface, instead of handling the distinction between what happens synchronously and asynchronously yourself, 
your resolver is never called until all other possible data been resolved, and what's passed into the resolve method is an array of wrapper objects, 
each containing the typical arguments that would normally be passed singly ($value, $args, etc). 
The resolve logic then handle the items all at once. _(Magento\Framework\GraphQl\Query\Resolver\Value_ is actually still used under the hood; 
a wrapper class simply sets up the asynchronous structure for you.) 
The resolve method must instantiate a Magento\Framework\GraphQl\Query\Resolver\BatchResponse and use addResponse to accumulate the resolved data matching each request that was passed in.
Example in _Magento\RelatedProductGraphQl\Model\Resolver\Batch\AbstractLikedProducts_.