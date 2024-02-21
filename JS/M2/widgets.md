```javascript
define(
    [
        'jquery',
        'mage/storage',
        'jquery-ui-modules/widget'
    ], ($, storage) => {

        $.widget('tsum.bestResult', {
            options: {
                title:'Default title',
                getResultsUrl: 'rest/V1/digits/best',
                results: []
            },

            _create() {
                this._renderTitle();
                // for the case of outside invoking rendering results, needs to comment rendering and invoke outside
                this.loadResults();
            },
```
- the entry point is _create or _init
- this._on - can use for events handling like:
```javascript
this._on(element, {
        mouseenter: function (event) {
          this._addClass($(event.currentTarget), null, 'ui-state-hover');
        },
        mouseleave: function (event) {
          this._removeClass($(event.currentTarget), null, 'ui-state-hover');
        }
      });
```
- check if form is valid (if to form was added validation widget)
```javascript
this.element.validation('isValid')
```
or
```javascript
if ($(form).validation('isValid')) {
```