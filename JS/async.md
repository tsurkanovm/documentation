- _defer is a function provided by the Underscore.js library, and it is somewhat similar to using setTimeout(fn, 0)
- both _.defer and setTimeout(fn, 0) are used to delay the execution of a function until the call stack is clear. This means the function will execute after the current call stack is empty, essentially making the execution asynchronous.
```javascript
setTimeout(console.log('Say hi!'), 0); // this will invoke after all stack is done
console.log('Say hello?'); // will go first
```
### Promises
```javascript
const LocationPromise = new Promise((resolve, reject) => {
    // write asinc code
  navigator.geolocation.getCurrentPosition(
      posData => {
        resolve(posData); // define what data we provide to 'then' function (success case)
      },
      errorMsgObj => {
        reject(errorMsgObj); // define what data we provide to 'catch' function (fail case)
      }
  );
});

function trackUserHandlerPromiseBy() {
  LocationPromise.then(successData => {
    console.dir(successData);
  }).catch(errorObj => {
    console.dir(errorObj);
    alert(errorObj.message);
  }).then(what => {
    console.dir(what); // what is undefined, because previous than returned default promise (not resolving to anything), we can return our promise to continue the chain
      console.log('All is done');
  })
}

trackUserHandlerPromiseBy();
console.log('Run directly');
```
States of promise object:
- PENDING => Promise is doing work, neither then() nor catch() executes at this moment 
- RESOLVED => Promise is resolved => then() executes 
- REJECTED  => Promise was rejected => catch() executes

##### Promise chain
When you have another then() block after a catch() or then() block, the promise re-enters PENDING mode (keep in mind: then() and catch() always return a new promise - either not resolving to anything or resolving to what you return inside of then()). Only if there are no more then() blocks left, it enters a new, final mode: SETTLED.
Once SETTLED, you can use a special block - finally() - to do final cleanup work. finally() is reached no matter if you resolved or rejected before, and does not return a promise.
If after a catch we have then - they are would invoke even previous then failed (catch was invoke). If we want to catch all (or any) issues - it should be the last. 

#### Async and await syntax
Pretty the same as above but by async and await:
```javascript
const button = document.querySelector('button');

const getLocation = () => { // the same part we need the Promise
    return new Promise((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(
      posData => {
          console.dir(posData);
        resolve(posData);
      },
      errorMsgObj => {
        reject(errorMsgObj);
      }
  );
})};

async function trackUserHandlerPromiseAsyncBy() { // function that we use Promise need async prefix, and it turns this func to return a Promise
    try {
        await getLocation(); // then() analogy
        console.log('Finality-fatality!!');
    } catch (error) {  // catch analogy, the error - will be data from reject defenition
        console.log(error.message);
    }
}

console.log('Run ... ');
button.addEventListener('click', trackUserHandlerPromiseAsyncBy);
```