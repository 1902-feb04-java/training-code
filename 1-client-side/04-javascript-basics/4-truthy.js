'use strict';

function convertToBool(x) {
    let bool = Boolean(x);
    console.log(`${x} as boolean: ${bool}`);
}

// values are converted to boolean in places like an if-condition.
// if (condition) {

// }

// most values convert to true, we call those values "truthy"
// some convert to false, we call them "falsy"

// falsy values:
// 0 (and -0)
// NaN
// '' (empty string)
// false
// null
// undefined


// everything else is truthy, including all objects, functions, arrays, etc.

// often we use "null" to indicate the absence of an object
let object = getTheObject(); // example function

// if this is null, converts to false. if any object, converts to true.
if (object) {

}

// for-of loop in ES6, can use with any collection
for (const x of [1, 2, 3, 4]) {

}

//ES6 also added collections Set and Map
