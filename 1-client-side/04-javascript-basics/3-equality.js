'use strict';

function compare(a, b) {
    // another thing ES6 added, string interpolation
    // console.log("a: " + a + ", b: " + b);
    // instead of that, we can write this:
    console.log(`a: ${a}, b: ${b}`);
    // you use backticks (`) instead of quotes
    // and put JS expression inside ${ }
    console.log(`a == b: ${a == b}`);
    console.log(`a === b: ${a === b}`);
}

// == "double-equals" or loose equals (negation: !=)
// === "triple-equals" or strict equals (negation: !==)

// compare(1, 1);
// compare(0, 1);
// compare(5, '5');
// compare('', 0);
// compare(1, [1]);
// compare(1, 1.0);
// compare(0, [[]]);
// compare(0, [[[1]]]);
compare({}, {}); // not equal -- we're comparing reference equality for objects, not value equality
compare(NaN, NaN); // not equal by floating-point rules
// but we do have a function isNaN() to check that

// double-equals tries to "compare value without comparing type"
// triple-equals compares both value and type
