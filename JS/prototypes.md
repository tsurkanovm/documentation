Prototype – only on constructor function
__proto__ - any object
Using prototypes almost the same as inheritance with small differences

```javascript
class Something {
    
    method1() {
        //...
        // will created for prorotype only not for the object itself
        // this is kid of optimization, less memory will use (not re-created per instance)
    };
    
    method2 = () => {
        //...
        // will create for the object itself (no matter if you use arrow function or not, if you use attribute it will "move" to a prototype)
    };
}
let test = {};
Object.getPrototypeOf(test); // it is the same as test.__proto__

// we can set or change prototype
Object.setPrototypeOf(obj, {
     ...Object.getPrototypeOf(obj), // we extend existing proto of obj
    printRating: function() {
        console.log(`${this.rating}/5`);
    }
});

const student = Object.create({  // we cretae new object and set proto and configured "name" attr
    printProgress: function() {
        console.log(this.progress);
    }
}, {
    name: {
        configurable: true,
        enumerable: true,
        value: 'Max',
        writable: true
    }
});
```
