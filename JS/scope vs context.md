### Scope
Scope has to do with the the visibility of variables. 
In JavaScript, scope is achieved through the use of functions. 
When you use the keyword “var” inside of a function, the variable that you are initializing is private to the function, and cannot be seen outside of that function. 
But if there are functions inside of this function, then those “inner” functions can “see” that variable, and that variable is said to be “in-scope”. 
```javascript
    month = 'july'; //global variable

    function foo(){
        var month = "august"; //private
        console.log(month);
    };

    console.log(month); //in the global scope, month = july

    foo(); //in the local scope of the foo function, month = august
```
this is the same, cause the month was declared outside any block, so its global as well 
```javascript
    let month = 'july'; //it steel global variable

    function foo(){
        console.log(month);
    };

    foo(); //in the local scope of the foo function, month = july
```

#### var vs let vs const
   Scope:
   - var is function-scoped, meaning it is limited to the function in which it is declared. If declared outside a function, it becomes globally scoped.
   - let is block-scoped, meaning it is limited to the block (like loops or if statements) in which it is declared. However, if declared outside any block, it behaves like a global variable.
   - const is block-scoped, **are read-only and cannot be reassigned**. Note that when an object is declared with const, the object itself can't be reassigned, but the properties within the object can still be changed.
   
Hoisting (raising):
   - Variables declared with var are hoisted to the top of their function scope before code execution.
   - Conversely, let and const declarations are not hoisted. They are hoisted to the top of their block, 
but they are not initialized. This means that a ReferenceError will be thrown if you try to use them before their declaration within the block.

   Example for var:
```javascript
function foo(){
    if (true) {
        var month = 'july'; 
    }
    console.log(month); // Works fine, as var is function-scoped
};
foo();
```

Example for let:
```javascript
function foo(){
    if (true) {
        let month = 'july'; 
    }
    console.log(month); // ReferenceError: month is not defined, as let is block-scoped
};
foo();
```

### Context
Context is related to objects. It refers to the object to which a function belongs. 
When you use the JavaScript “this” keyword, it refers to the object to which function belongs.
To change a contex you can use the apply or bind function (they do the same thing, but they do so in different ways).
#### apply
The apply method is used **_to invoke a function with a given this value_** and arguments provided as an array (or an array-like object)
- syntax: function.apply(thisArg, [argsArray])
- example:
```javascript
function greet(firstName, lastName) {
    console.log('Hello ' + firstName + ' ' + lastName);
}

greet.apply(null, ['John', 'Doe']); // Output: "Hello John Doe"
```

```javascript
const Greet = {
    firstName: 'test',
    lastName: 'Tetster',
    hallo: function (greety) {
        if (!greety) {
            greety = 'Hallo';
        }
        alert(`${greety} ${this.firstName} ${this.lastName}`);
    }
};

const JohDou = {
    firstName: 'John',
    lastName: 'Dou',
}
Greet.hallo.apply(JohDou, ['Hi']); // Output: "Hi John Doe"
//Greet.hallo.apply(JohDou); // Output: "Hallo John Doe"
//Greet.hallo.apply(null); // Output: "Hallo unerfined unerfined"
```
#### bind
The bind method _**creates a new function**_ that, when called, has its this keyword set to the provided value, 
with a given sequence of arguments preceding any provided when the new function is called.
- syntax: function.bind(thisArg[, arg1[, arg2[, ...]]])
- thisArg is the value to which this should be bound. The arg1, arg2, ... are arguments to prepend to arguments provided to the bound function when invoking it.
- example:
```javascript
const Greet = {
    firstName: 'test',
    lastName: 'Tetster',
    hallo: function (greety = 'Hallow', exclamation = '!') {
        alert(`${greety} ${this.firstName} ${this.lastName}${exclamation}`);
    }
};

const JohDou = {
    firstName: 'John',
    lastName: 'Dou',
}
let newgreetingFunc = Greet.hallo.bind(JohDou, 'Hi');
newgreetingFunc('!!!'); // Output: "Hi John Doe!!!"
```