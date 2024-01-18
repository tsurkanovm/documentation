#### observable
use initObservable instead of ko.observable() function in defaults:
it will hande the situation when attributes will set in phtml as preferable values
```javascript
initObservable: function () {
            this._super()
                .observe([
                    'imageItems',
                    'messages'
                ]);

            return this;
        },

        getMessages: function () {
            return this.messages();
        },
```

#### tracks
the same as above, but it creates functional attributes, that no more a function:
```javascript
    defaults: {
        messages: [],
            tracks: {
                imageItems: true,
                messages: true
            }
        },
    getMessages: function () {
        return this.messages;
    },
```
#### uiRegistry and naming
View all uiComponent on a page (run in console):
```javascript
    require('uiRegistry').get(component => {console.log(component.name)})
```

#### linking
- imports
- exports
- links (full links - changes will be tracked in both components)
- listens (we can provide callback for changing var from other component or event yours var - like subscribe)
- modules (something like to add to dependencies)

#### literals
‘${1 + 1}’ and  `${1 + 1}` will parse, first only in M2, second from es6.
`${ $.provider }:taskText` - the second $ - equals this
- ignoreTmpls (has the same syntax as tracks obj, here you can defined properties that will ignore literals substitution):
  ```javascript
      ignoreTmpls: {
        fieldAction: true
      },
    ```
- provider 
(predefined property (empty) to use it in your code unify with using this name by literals and not use specific components names)

#### hierarchy and dependency
- UiClass → UiElement → UiCollection (has children, the synonym of UiComponent, so they are the same)
So we can use UiElement if we know that our component wont have child

- for dependency one component from another  better to use **deps** - property then add component itself to dependency (even though it works as well)
when you define deps - the firs element will populate to the provider property for the future use
The deps property needs to define on phtml or xml. In defaults it`s to late, components already created and deps will be empty. 
It is only one issue with defaults options, other config should be define there.

#### statefull
```javascript
            listens: {
                'selectedOption': 'applyChanges'
            },
            statefull: {
                selectedOption: true,
                applied: true
            },
            exports: {
                applied: '${ $.provider }:params.sorting'
            },
```
we can store state (values) of properties after page reloading, by using statefull object. 
Be careful it stores to the local storage (AppData key) and doesn`t have any logic to validate and change it from BE or from other scripts (only direct settings. 
I mean that it is not a customer data it is like cookie withoud access from BE)