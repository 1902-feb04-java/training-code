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
});
