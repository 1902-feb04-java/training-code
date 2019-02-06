'use strict';

// objects can have functions as properties too
// object-oriented idea: encapsulate data and behavior together
let obj = {
    name: 'Nick',
    sayName: function() {
        console.log('Nick');
    },
    sayName2: function() {
        // "this" refers to the object
        // before the dot when this
        // function is called.
        console.log(this);
        console.log(this.name);
    }
};

let obj2 = {
    name: 'Bob',
    sayName2: obj.sayName2
};

obj.sayName();

obj.sayName2();

obj2.sayName2();

// reminder on functions as values
// don't confuse these
function returns3() {
    return 3;
}
let theFunctionItself = returns3; // a function
let theFunctionsReturnValue = returns3(); // 3

// ES5 has no classes, but it does have constructors
// (we've used Boolean, String)

// name constructors with capital latter
function Person(name, age, fingers) {
    // define data properties of a new Person
    this.name = name;
    this.age = age;
    this.fingers = fingers;

    // define methods/functions of a new Person
    this.sayName = function() {
        console.log(this.name);
    }
}

// we call constructors with the "new" keyword
let nick = new Person('Nick', 26, 10);
console.log(nick);
nick.sayName();
// all that "new" does is...
// 1. make a new empty object ({})
// 2. then call the function you put after
//    the "new" with "this" set to that new object.

// ES5 uses prototypal inheritance to have something LIKE
// a "class heirarchy" without classes.

// a "Student" will have everything a Person has, and also
// a "school" property.
function Student(name, age, fingers, school) {
    this.school = school;
    this.__proto__ = new Person(name, age, fingers);
}

// the way property access works in JS is, if we try to access
// a property on an object, and it's not defined on that object

// ... we fall back to that object's prototype, and on and on
// until we hit Object (which has no prototype).

let student = new Student('Bill', 50, 10, 'UW');
student.fingers = 12;
console.log(student);
console.log(student.name);

console.log({});
console.log({}.toString());

// in ES6, we can use classes instead of old-fashioned constructors and prototypes

class PersonClass {
    constructor(name, age, fingers) {
        // define data properties of a new Person
        this.name = name;
        this.age = age;
        this.fingers = fingers;
    }

    // define methods/functions of a new Person
    // this is called "method" syntax for adding a function property to an object.
    sayName() {
        console.log(this.name);
    }
}

// (method syntax works on objects too)
let x = {
    returns3() {  // new in ES6 (i think)
        return 3;
    }
}

// PersonClass will be the parent class of StudentClass
class StudentClass extends PersonClass {
    constructor(name, age, fingers, school) {
        // "super" means, the parent class's constructor
        super(name, age, fingers);

        this.school = school;
    }
}

let student2 = new StudentClass('Mehrab', 90, 5, 'UH');
console.log(student2);

// ES6 classes are essentially just syntactic sugar around prototypal inheritance
