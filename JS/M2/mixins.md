### 1. Functions
It is like PHP plugins. We can add functionality before and after original function, edit input params, or totally rewrite original function
example:
Origin file:
```javascript
define(['mage/storage',], storage => {
    return payload => {
        const serviceUrl = 'rest/V1/digits/save';
        console.log(payload);
        storage.post(serviceUrl, JSON.stringify({'result' : payload}));
    };
})
```
Mixin:
```javascript
define(['mage/utils/wrapper'], (wrapper) => {
    return function (extendedFunction) {
        return wrapper.wrap(
            extendedFunction,
            function (originFunction, payload) {
                payload = {...payload, 'justTest': 'it is works!'};
                originFunction(payload);
            }
        )
    }
})
```

### 2. Object
We can new function and prop to origin obj, or change the result (and input params value) for existing methods:
Origin file:
```javascript
define([], () => {
    return {
        payload: {
            hits: 8,
            time: 88,
            customer_id: 1
        },

        getPayload: function (size) {
            this.payload = {...this.payload, size: size};

            return this.payload;
        }
    }
})
```
Mixin:
```javascript
define(['mage/utils/wrapper'], (wrapper) => {
    return function (originObject) {
        // add new function
        originObject.somethingNew = function () {
            console.log('New');
        };

        // extend existing one
        originObject.getPayload = wrapper.wrapSuper(originObject.getPayload, function () {
            // get result of origin function with new size value (origin it is 4)
            let newSizePayload = this._super(5);

            // add new key
            return {... newSizePayload, fakeKey:'from stupid mixin'}
        });

        return originObject;
    }
})
```
### 3. Widget
It is similar to object mixin but without wrappers. Uses $.widget inheritance functionality:
Mixin is:
```javascript
define(['jquery'], ($) => {
    const mixin = {
        // add functionality after existing function
        _handleSuccessResults(response)  {
            this._super(response);
            // if origin funct returns value we can get it and edit:
            // let result = this._super(response);
        }
    };

    return function (originWidget) {

        // aka extend
        $.widget('tsum.bestResult', originWidget, mixin);

        return $.tsum.bestResult;
    }
})
```
### 4. UiComponent
The same as widget, uses extend functionality:
```javascript
define([], () => {
    return (originDigits) => {
        return originDigits.extend(
            {
                getStrokePlaceholder: function ()
                {
                    let originResult = this._super();
                    originResult += ' this part from mixin';

                    return originResult;
                }
            }
        );
    }
})
```
