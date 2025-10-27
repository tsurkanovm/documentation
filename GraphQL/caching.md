### Some basics
Magento's GraphQL implementation supports caching of responses via the same page cache storage system as for FPC (although with some different concepts in the Magento application itself.)
For any requests to the /graphql URL path, the X-Magento-Vary cookie is not used (as for GET requests by FPC). Instead, a header named X-Magento-Cache-Id serves the same basic purpose.
If an authorization token is included in an initial request, the cached response will only be returned when the token is present on subsequent requests as well.
X-Magento-Vary manages by - Magento\Framework\App\Http\Context.

### Magento-Cache-Id Factor
For GraphQL requests, the generation of the X-Magento-Cache-Id header value is instead controlled by Magento\GraphQlCache\Model\CacheId\CacheIdCalculator.
You can add new factor by DI:
```xml
<type name="Magento\GraphQlCache\Model\CacheId\CacheIdCalculator">
    <arguments>
        <argument name="idFactorProviders" xsi:type="array">
            <item name="customergroup" xsi:type="object">
                Magento\CustomerGraphQl\CacheIdFactorProviders\CustomerGroupProvider
            </item>
            <item name="customertaxrate" xsi:type="object">
                Magento\CustomerGraphQl\CacheIdFactorProviders\CustomerTaxRateProvider
            </item>
            <item name="isloggedin" xsi:type="object">
                Magento\CustomerGraphQl\CacheIdFactorProviders\IsLoggedInProvider
            </item>
        </argument>
    </arguments>
</type>
```
Out of the box, the following information is included in the hashed ID:
- Store ID 
- Store currency 
- Whether the customer is logged in 
- Customer group ID 
- Customer tax rate

### Limitations
Magento's built-in page cache does not support the X-Magento-Cache-Id header (factor Id, but it caches by url and identities) Only Varnish, Fastly.
If you are only able to use the built-in cache, you can still observe the effects of caching on GraphQL requests in general, but you will not see cache hits when authorization tokens are involved.

As if an URL path is always /graphql. This won't work for caching, which is why the query and variables must actually be included in the querystring rather than the request body, in the form:
`/graphql?query={url-encoded-query}&variables={url-encoded-json}`
We should note here that, while the caching of typical web pages includes any page by default and requires un-cacheable pages to be declared as such, the opposite is true for GraphQL requests: A resolver requires specific configuration and added functionality in order to be cacheable.

### Implementation
```graphql
type Query {
    cmsPage (
        id: Int @doc(description: "The ID of the CMS page.") @deprecated(reason: "Use `identifier` instead.")
        identifier: String @doc(description: "The identifier of the CMS page.")
    ): CmsPage @resolver(class: "Magento\\CmsGraphQl\\Model\\Resolver\\Page") @doc(description: "Return details about a CMS page.") @cache(cacheIdentity: "Magento\\CmsGraphQl\\Model\\Resolver\\Page\\Identity")
    cmsBlocks (
        identifiers: [String] @doc(description: "An array of CMS block IDs.")
    ): CmsBlocks @resolver(class: "Magento\\CmsGraphQl\\Model\\Resolver\\Blocks") @doc(description: "Return information about CMS blocks.") @cache(cacheIdentity: "Magento\\CmsGraphQl\\Model\\Resolver\\Block\\Identity")
}
```
```php
class Identity implements IdentityInterface
{
    /** @var string */
    private $cacheTag = \Magento\Cms\Model\Page::CACHE_TAG;

    /**
     * Get page ID from resolved data
     *
     * @param array $resolvedData
     * @return string[]
     */
    public function getIdentities(array $resolvedData): array
    {
        return empty($resolvedData[PageInterface::PAGE_ID]) ?
            [] : [$this->cacheTag, sprintf('%s_%s', $this->cacheTag, $resolvedData[PageInterface::PAGE_ID])];
    }
}
```
So it works pretty the same as for http. Each entity that needs to be cached should implement IdentityInterface with own tag. 
If schema contain a cache Resolver - this resolver set what identities specifically this query contains. And if origin entity would change - it will purge all cached query with this specific identity.
If @cache not defined or ```@cache(cacheable: false)``` - query not cached.


#### I dont understand - Fastly caches only by factor ID, and if cache resolver set - additionally? Is it return the same result if token will change?