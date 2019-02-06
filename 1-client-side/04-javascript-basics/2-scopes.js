'use strict';

// when we standardized ES5, we fixed some issues
// but you have to opt-in with 'use strict' so that
// old code can still work the old way.

// you can opt-in on a per-function basis, or on the whole file.

// until ES6, we had two scopes in JS:
// 1. global scope
// 2. function scope

var a = 3;
// global scope of anything out here.

function f(x) {
    // variables declared with "var"
    // anywhere in a function have the
    // scope of that whole function.

    // this is not an error, only undefined
    console.log(n);
    // we say that the declaration ("var n") is hoisted to the top of the function
    if (true) {
        var n = 3;
    } else {
        var n = 8;
    }

    // without strict mode, you can set global variables so long as you don't declare them (you leave out var).
    // asdf = 5;
    // ^^  becomes a ReferenceError with strict mode

    // with function scope, we can still see that n even though we're outside its braces.
    return x + n;
}
f(4);
// console.log(n); // ReferenceError -- (n is out of scope)

// in general, strict mode turns silently thrown-away errors
// into real thrown errors.
// if assignments fail, that's a thrown error

// JavaScript does have exception throwing and handling

function bad() {
    throw 'an error happened';
}

try {
    // we put code that might throw an error in the try block
    bad();
} catch (error) {
    // then we put code to recover from the error in the catch block
    console.log(error);
}
// the catch block does not run unless there was an error.

// ES6 added block scope to JavaScript
// with two new ways to declare a variable - let and const.

// when you use "var", it's function scope (or global)
// when you use let or const, it's block scope (or global)

// always use let or const, not var.

if (true) {
    // var asdf = 5;
    let asdf = 5;

    // you can never re-assign to a const variable.
    const qwerty = 7;
    // qwerty = 3; // error - const
}
// console.log(asdf); // error - block scope

const obj = {
    name: 'Nick'
};

// obj = {}; // error - can't reassign const
obj.age = 26; // not an error - const only protects the variable itself

let name = 'Bill';
let age = 50;

let bill = {
    name: name,
    age: age
};

// ES6 introduced "shorthand property initializer"
// this does the exact same as the line above.
bill = { name, age };
