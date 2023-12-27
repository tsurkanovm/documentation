#### bindings
text, html, style, class, css, visible, enable, disable ... 
also has bindings on events like click and submit (there is a difference with params that will be send 
to callback function (viewModel, event) if you use events (only event)) 

- checked
works in both ways - read and write
```html
<input data-bind="checked: isChecked"/>  //write and read as own status (by click isChecked changes)
<button data-bind="enable: isChecked">Submit</button> //read

```
```html
<button data-bind="click : onClick"></button> 
<a data-bind="attr: { href: url, title: details }">
    Report
</a>
```

#### observable
- Only primitive values
  If you want observe an object (attributes) you will need invoke - valueHasMutated() function
- For arrays - observableArrays()
  you can bind get attributes of observable object like this:
  ```<p data-bind="text : obj().attr"></p>```
computed example:
```javascript
let viewModelComputed = function()
    {
        this.name  = ko.observable('');
        this.sec  = ko.observable('');
        this.cardHolder  = ko.observable('');

        // pure only for return
        // this.customerName = ko.pureComputed(function () {
        //     return `${this.name()} ${this.sec()}`;
        // }, this);

        // if we set something needs use computed instead of pureComputed
        this.customerName = ko.pureComputed(function () {
            let fullName = `${this.name()} ${this.sec()}`;
            this.cardHolder(fullName.toUpperCase());

            return fullName;
        }, this);
    }
```
```html
<div id="computed">
    <label for="name"></label>
    <input type="text" name="name" id="name" data-bind="textInput: name" autocomplete="off"/>

    <label for="second-name"></label>
    <input type="text" name="second-name" id="second-name" data-bind="textInput: sec" autocomplete="off"/>

    <p>Customer Name: <strong data-bind="text: customerName"></strong></p>
    <p>Card Holder: <strong data-bind="text: cardHolder"></strong></p>
</div>
```
#### Select with options
``` javascript
    let viewModelConstructor = function()
    {
        this.theValue = ko.observable(0);
        this.optionsCaption1 = 'first list ...';
        this.options = ko.observableArray(['option - 1', 'option - 2']);
        this.selectedOpt = 'option - 2';
        this.add = function(){
            this.options.push(`option - ${this.options().length + 1}`);
            this.theValue(this.options().length);
        };

        // for the second list
        this.optionsCaption2 = 'Second list ...';
        this.optionsObj = ko.observableArray(
            [{label: 'opt1', value:1}, {label: 'opt2', value:2}]
        );
    };

    ko.applyBindings(new viewModelConstructor);
```
```html
<div id="main">
    <p data-bind="text:theValue"></p>
    <select data-bind="options: options, value: selectedOpt, optionsCaption: optionsCaption1"></select>
    <select data-bind="options: optionsObj, optionsText: 'label', optionsValue: 'value', optionsCaption: optionsCaption2">
    </select>
    <div>
        <br/><br/>
        <button data-bind="click: add" id="button">Do It</button>
    </div>
</div>
```

#### If -> ifnot
Ko does not have the else statement, uses ifnot or !
```html
<div data-bind="if: isActive"></div>      //if
<div data-bind="ifnot: isActive"></div>   // else
<div data-bind="if: !isActive()"></div>   // another way ot else

```

#### foreach
$data - current element
$context - current context
$context.root - it is always the root context
$context.parent - parent context (previous foreach)
$context.parents - array of all level parents 

##### Example:
```html
    <!-- ko foreach: collection -->
    <!-- ko text: console.log('First Level ', $data) --><!-- /ko -->
        <!-- ko foreach: $data -->
    <!-- ko text: console.log('Second Level ', $context) --><!-- /ko -->
            <button data-bind="click: $root.onClick">Try to click</button>
        <!-- /ko -->
    <!-- /ko -->
```
```javascript
let viewModelForeach = function()
    {
        this.collection = ko.observableArray([['first', 'second'], ['third']]);

        this.onClick = function(element, event){
            console.log('Event is ', event);
            console.log('Value is ', element);
        };
    }
```
Not all bindings and functions have alternative syntax
 