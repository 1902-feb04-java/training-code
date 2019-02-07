'use strict';

// runs first
console.log('1');

document.addEventListener('DOMContentLoaded', () => {
    let jokeHeader = document.getElementById('joke-text');
    let jokeButton = document.getElementById('joke-button');

    // runs third
    console.log('2');

    jokeButton.addEventListener('click', () => {
        // runs fifth
        console.log('3');

        // we'll write a getJoke to make a request to the joke API
        let jokeText = getJoke();

        jokeHeader.textContent = jokeText;
    });

    // runs fourth
    console.log('4');
});

// runs second (the handler for DOMContentLoaded has not run yet!)
console.log('5');

// 24153
// 15243
// 12345

function getJoke() {
    // this object is provided by the browser to let us do AJAX
    // AJAX stands for Asynchronous JavaScript and XML
    //   but what it means in practice is, HTTP requests via JavaScript.
    let xhr = new XMLHttpRequest();

    xhr.addEventListener('readystatechange', () => {
        console.log(`readyState: ${xhr.readyState}`);

        if (xhr.readyState === 4) {
            // 4 means, we've recieved the response
            let responseJSON = xhr.response;
            console.log(responseJSON);

            // HTTP response status 200-299 indicates success.
            if (xhr.status >= 200 && xhr.status < 300) {

            }
        }
    });
}
