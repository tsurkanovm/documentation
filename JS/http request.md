Example by HttpRequest:

```javascript
const listElement = document.querySelector('.posts');
const postTemplate = document.getElementById('single-post');
const form = document.querySelector('#new-post form');
const fetchButton = document.querySelector('#available-posts button');
const postList = document.querySelector('ul');

function sendHttpRequest(method, url, data) {
  const promise = new Promise((resolve, reject) => {
  const xhr = new XMLHttpRequest();
  xhr.setRequestHeader('Content-Type', 'application/json');
  //xhr.setRequestHeader('Another Header', 'something');

    xhr.open(method, url); // initiate

    xhr.responseType = 'json';

    xhr.onload = function() {
      if (xhr.status >= 200 && xhr.status < 300) {
          resolve(xhr.response);
      } else {
          // handle 404 and 500 errors, that technically success request/response
          xhr.response;
          reject(new Error('Something went wrong!'));
      }
    };

    xhr.onerror = function() {
        // something wrong, time out etc... server not response
      reject(new Error('Failed to send request!'));
    };

    xhr.send(JSON.stringify(data)); // main instruction - send json request
  });

  return promise;
}

async function fetchPosts() {
  try {
    const responseData = await sendHttpRequest(
      'GET',
      'https://jsonplaceholder.typicode.com/posts'
    );
    const listOfPosts = responseData;
    for (const post of listOfPosts) {
      const postEl = document.importNode(postTemplate.content, true);
      postEl.querySelector('h2').textContent = post.title.toUpperCase();
      postEl.querySelector('p').textContent = post.body;
      postEl.querySelector('li').id = post.id;
      listElement.append(postEl);
    }
  } catch (error) {
    alert(error.message);
  }
}

fetchButton.addEventListener('click', fetchPosts);

postList.addEventListener('click', event => {
  if (event.target.tagName === 'BUTTON') {
    const postId = event.target.closest('li').id;
    sendHttpRequest(
      'DELETE',
      `https://jsonplaceholder.typicode.com/posts/${postId}`
    );
  }
});
```
Pretty the same by fetch() and use FormData:
```javascript
const listElement = document.querySelector('.posts');
const postTemplate = document.getElementById('single-post');
const form = document.querySelector('#new-post form');
const fetchButton = document.querySelector('#available-posts button');
const postList = document.querySelector('ul');

function sendHttpRequest(method, url, data) {
  return fetch(url, {
    method: method,
    // body: JSON.stringify(data), // needs uncomment if use JSON instaed of FormData
    body: data,
    // headers: {
    //   'Content-Type': 'application/json'  // example how to set headers for fetch API
    // }
  })
    .then(response => {
      if (response.status >= 200 && response.status < 300) {
        return response.json(); // promise with result
      } else {
        return response.json().then(errData => {
          console.log(errData);
          throw new Error('Something went wrong - server-side.');
        });
      }
    })
    .catch(error => {
      console.log(error);
      throw new Error('Something went wrong!');
    });
}

async function fetchPosts() {
  try {
    const responseData = await sendHttpRequest(
      'GET',
      'https://jsonplaceholder.typicode.com/posts'
    );
    const listOfPosts = responseData;
    for (const post of listOfPosts) {
      const postEl = document.importNode(postTemplate.content, true);
      postEl.querySelector('h2').textContent = post.title.toUpperCase();
      postEl.querySelector('p').textContent = post.body;
      postEl.querySelector('li').id = post.id;
      listElement.append(postEl);
    }
  } catch (error) {
    alert(error.message);
  }
}

async function createPost(title, content) {
  const userId = Math.random();
  const post = {
    title: title,
    body: content,
    userId: userId
  };

  const fd = new FormData(form); // as data source use the FormData, it get form and automatically prepared data (by names of html elements)
  // fd.append('title', title);
  // fd.append('body', content);
  fd.append('userId', userId); // we can add any data to it

  sendHttpRequest('POST', 'https://jsonplaceholder.typicode.com/posts', fd); // add form data and it automativally set fd data type
}

fetchButton.addEventListener('click', fetchPosts);
form.addEventListener('submit', event => {
  event.preventDefault();
  const enteredTitle = event.currentTarget.querySelector('#title').value;
  const enteredContent = event.currentTarget.querySelector('#content').value;

  createPost(enteredTitle, enteredContent);
});

postList.addEventListener('click', event => {
  if (event.target.tagName === 'BUTTON') {
    const postId = event.target.closest('li').id;
    sendHttpRequest(
      'DELETE',
      `https://jsonplaceholder.typicode.com/posts/${postId}`
    );
  }
});
```