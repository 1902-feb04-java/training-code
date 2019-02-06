'use strict';

// callback functions

function add(a, b, onSuccess) {
    let result = a + b;
    onSuccess(result);
    // instead of returning the result, i'll pass it to
    // a function given me by the caller
}

// --------

add(1, 2, function (result) {
    console.log(result);
});

// my "add" function allows me to "inject" any behavior i want into it,
// for it to apply to the result.

// that third parameter is called a callback function,
// because the add function "calls back" to the calling code.

// makeHTTPRequest(url, function () {
//     // when operation is done, run this function
// });
// but not yet, i can still run code in the meantime down here.

// in ES6, we got a new syntax for function expressions
// called "arrow functions"
add(1, 2, result => console.log(result));
// we can do zero-arg arrow functions like this:
let func = () => 3; // takes zero parameters, returns 3.
// many args like this:
let multiply = (x, y) => x * y; // takes two params, returns product.
// can also do "block body" arrow functions
let max = (x, y) => {
    if (x > y) return x;
    return y;
};
// with block body (i.e. braces {}) I use statements separated by semicolons
// without braces, i provide one expression

// the way "this" works is different with arrow functions.

// regular functions, "this" always refers to
// whatever object to the left of the "."
// when the function is being called.

let obj = {
    name: 'bob',
    func1: function () {
        console.log(this.name);
    },
    func2: () => console.log(this.name)
}

let obj2 = {
    name: 'bill',
    func1: obj.func1,
    func2: obj.func2
}

obj2.func1();
obj2.func2();

// for arrow functions, it copies "this" from the
// surrounding context

function newCounter() {
    let x = 0;
    return function() {
        x++;
        return x;
    }
}

debugger;

let counter = newCounter();

console.log(counter());
console.log(counter());
console.log(counter());

let counter2 = newCounter();

console.log(counter2());
console.log(counter2());


// this is using the behavior of "closure"
// i have no ability to directly access "x"
// from out here, yet the variable is kept alive

// the inner function (that newCounter returns)
// "closes over" all the variables it references,
// i.e. it closes over "x".

// sometimes we call the inner functions themselves
// "closures"

// IIFE
// immediately-invoked function expression
let library = (function() {
    let privateData = 0;

    function privateFunction() {
        return privateData;
    };

    return {
        libraryMethod() {
            return privateFunction() + 1;
        },
        // ...
    };
})();

library.libraryMethod();

// anonymous function that we call as soon
// as we write it
(function () { console.log('immediately'); })();
