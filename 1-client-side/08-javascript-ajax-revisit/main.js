'use strict';

document.addEventListener('DOMContentLoaded', () => {
    // step 1, get the special XmlHttpRequest object from the browser
    let httpRequest = new XMLHttpRequest();

    // step 2, define what should happen when "readystatechange"
    //  event occurs.
    httpRequest.onreadystatechange = () => {
        // this will fire several times, but we only care about
        // when the response is done. (when readyState === 4)
        if (httpRequest.readyState === 4) {
            // we're done, but, did it succeed or fail?
            if (httpRequest.status === 200) {
                // it succeeded, and the data is in
                // "response" or "responseText" properties
                // responseText is always the raw string
                // but response will have some deserialized thing
                // depending on what you set "responseType" to be
                console.log(httpRequest.response);
                // this will be a JS object taken from JSON
            } else {
                // it failed
                console.log('request failed!');
                console.log(httpRequest.statusText);
            }
        }
    };

    // tell the object i am expecting JSON data to be returned.
    httpRequest.responseType = 'json';
    // it will try to use JSON.parse, and put the results in
    // "response" property.

    // step 3, open the request
    httpRequest.open('get', 'https://jsonplaceholder.typicode.com/posts/');

    // step 4, send the request
    // (if we were sending data in the request body (e.g. a POST request))
    // we would provide it here
    httpRequest.send();
});

// all the ways we can specify functions in JS.

// 1. function statement
         function myfunction(param1, param2) {
             return param1;
         }
// 2. function expression
         let myfunction = function (param1, param2) {
             return param1;
         }

// with ES6, we also have:
// 3. arrow function
         let myfunction = (param1, param2) => param1;
// 4. arrow function with block body
         let myfunction = (param1, param2) => {
             return param1;
         };
// 5. method (in an object literal, or a class)
         let myobj = {
             myfunction(param1, param2) {
                 return param1;
             }
         };

// callback function
//     function that we pass into another function to inject custom behavior
//     to be run at some future time. e.g. event handler

// closure
//     define a variable in a function, access that variable from a nested function,
//     that nested function still has access to that variable even if it's out of scope.

// IIFE immediately invoked function expression
//     we use #2 or #3 above to write an unnamed (anonymous) function and immediately
//     execute it. this provides some encapsulation of the logic and keeps all the
//     variables used there out of global scope.
(() => {
    // iife with arrow function
    let x = 'stuff';
    console.log(x);
})();
// now x is out of scope, doesn't get in the way of other "x"
