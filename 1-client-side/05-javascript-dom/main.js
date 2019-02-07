'use strict';

// this won't work unless the script is loaded after the "body" node is created.
// document.body.style.backgroundColor = 'blue';

// there is a "load" event that runs on everything
// when the window is loaded, everything is loaded

// for every event, you can register a event handler with
// a property named "on<event-name>". an event handler is a function.

window.onload = function () {
    document.body.style.backgroundColor = '#eeeeee';
};

// javascript has a special object called the global object aka "window"
// every variable in global scope is actually stored on the window object.

// a more flexible way to do this:
window.addEventListener('load', () => {
    let header = document.body.firstElementChild;
    header.textContent = 'DOM changed this';
});

// ideally we don't wait all the way until window loads
// that means, all images etc have downloaded

// all we really need is the elements to exist in the DOM and not be null
// DOMContentLoaded event fires sooner
window.addEventListener('DOMContentLoaded', () => {
    let header = document.getElementById('header-text');
    let colA = document.getElementById('col-a');

    // we have getElementById, getElementsByClassName, getElementsByTagName
    // we also have querySelector (to get the first matching element)
    //   according to CSS selector syntax.
    // and querySelectorAll (to get all matching elements)

    document.querySelector('#header-text');

    let clickCounter = 0;
    header.addEventListener('click', () => {
        clickCounter++;
        header.textContent = `DOM changed this (clicked ${clickCounter} times)`;
        // we can use textContent property to get and set the text inside an element
        colA.innerHTML = '<em>Col</em> <u>A</u>';
    });

    colA.addEventListener('mouseover', () => {
        // we'll create an element
        let footer = document.createElement('h2');
        // we'll add some text inside it
        footer.textContent = '©2019 Revature';
        // we'll insert it into the DOM tree (specifically, at the end of the body)
        document.body.appendChild(footer);
    });

    let table = document.getElementById('the-table');

    // a listener on the first cell (bubbling)
    table.rows[0].cells[0].addEventListener('click', printEventDetails);
    // a listener on the whole table (bubbling)
    table.addEventListener('click', printEventDetails);

    // pass third parameter "true" (overriding default false)
    //   to set the handler to capturing mode.
    // a second listener on the whole table (capturing)
    table.addEventListener('click', printEventDetails, true);

    // events, bubbling vs capturing:
    //   http://javascript.info/article/bubbling-and-capturing/eventflow@2x.png


});

function printEventDetails(event) {
    // if your event handlers take an argument, it will be set to
    // the event object.

    // type is the name of the event, e.g. 'click'
    console.log(`event.type: ${event.type}`);
    // target is the element that fired the event originally.
    console.log(`event.target: ${event.target}`);
    // currentTarget is the element that this event handler is registered on.
    console.log(`event.currentTarget: ${event.currentTarget}`);
    // "this" is bound to the same as currentTarget (unless this is an arrow function)
    console.log(`this: ${this}`);
    console.log('');

    event.stopPropagation();

    // methods available on the event object:

    //  - preventDefault()
    //      browser has default event handlers - e.g.
    //              click on a form button submits,
    //              pressing enter on a form field also submits
    //              clicking on a link navigates to that page
    //      preventDefault lets us stop that default behavior from occurring.

    //  - stopPropagation()
    //      this switches off event handlers on elements that come later in the sequence of capturing, target, bubbling phase, etc.

    //  - stopImmediatePropagation()
            // this switches off all subsequent handlers of this event,
            // even ones on the same element (currentTarget).

    //  using these stopPropagation ones is generally bad practice
}
