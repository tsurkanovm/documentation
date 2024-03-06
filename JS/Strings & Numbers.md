- every number is a float number in JS (50 can be stores as 50.0)
- every number stores in binary system
- every calculation performs in binary and then convert into decimal (that`s why float calculations have some side effects)
```javascript
0.2 + 0.4 === 0.6; // => false
// but:
    (0.2 + 0.4).toFixed(2) === 0.6.toFixed(2); // => true

// check binary value:
(2).toString(2); // => '10'
0.2.toString(2); // => "0.001100110011001100110011001100110011001100110011001101"

1/0; // Infinity, Nan if calculates undefined values (at least one)
-1/0; // -Infinity

```