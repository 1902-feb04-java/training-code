'use strict';

console.log('Hello JS');

// type undefined
var x; // undefined

x = undefined; // undefined
x = {}.name; // (uninitialized variable or property)

// type number
x = 1;
x = 3.14;
// in JS, integers and decimal numbers have the same type
// our internal representation is basically "double"
// (64-bit IEEE floating-point)
x = Infinity;
x = -Infinity;
x = 4 / 0; // Infinity
x = 5 / 'abc'; // NaN (not-a-number)
x = NaN + 5;

// type string
x = 'abc';
x = "abc"; // single or double quotes exactly the same
x = "abc"[0]; // also a string

// type boolean
// two values, true and false
x = true;
x = (3 === 3) || false; // true

// type object
x = {}; // empty object
x = {
    name: 'Bill', // properties
    age: 30
};
x.height = 120;
x.height = '6 feet';
// x = x.name; // access properties with dot (.)
x = x['height']; // access properties with indexing ([])

// functions (still type object, even though typeof says different)
// in JS, functions are first-class objects
x = function(n) { return n; }
//  ^^^^^^^^^^^^^^^^^^^^^^^^^
//   "function expression"
x = x(x(x('abc')));
x = function(f, x) { return f(x); }
// x = typeof(x) === 'object'; // false, it's 'function'
x = x(function(n) { return n.length; }, 'asdfasdf');

// type null
// (typeof lies and says it's object)
x = null;
// undefined means "non-initialized variable"

// null means "no object here";

// type symbol (new in ES6)
// used for unique identifiers

// JS only has these types:
// number, string, boolean, object
// undefined, null
// symbol

console.log(x);
console.log('value of x: ' + x);
console.log('type of x: ' + typeof(x));

// in javascript, you don't actually have to end your lines with semicolon
//  (but sometimes it inferrs the end of line wrongly)

// JavaScript has familiar control structures from C, Java

if ('abc'.length > 1) {
    console.log('true');
}
// we have if, else if, else
// we have switch statement
// switch (key) {
//     case value:
//         break;
//     default:
//         break;
// }

// we have for loops, while loops, do-while loops
for (var i = 0; i < 10; i++) {
    console.log(i);
}

// we have arrays (object type)
x = []; // empty array
x = [1, 2, 3, 4, 5, 'abc', null];
console.log(x);

x.forEach(function(e) {
    console.log(e);
});

// we've seen function expressions
// we can also declare function variables this way:

// ES6 allows default parameters like this with c
// function add(a, b, c = 5) {
function add(a, b, c) {
    console.log(a, b, c);
    // this is a breakpoint
    debugger;
    return a + b + c;
}

// if you don't pass enough parameters, it's undefined
add(1, 2);
// if you pass too many, they are ignored
add(1, 2, 3, 4);

function print(x) {
    console.log(x);
}

// without any return, what will this do?
console.log(print(3));
// "void" functions (no return statement) return undefined.

console.log(add(1, 3, 'c'));
