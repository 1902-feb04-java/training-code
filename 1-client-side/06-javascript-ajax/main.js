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
        getJoke(text => {
            // this code runs when the request returns successfully
            jokeHeader.textContent = text;
        });
    });

    // runs fourth
    console.log('4');
});

// runs second (the handler for DOMContentLoaded has not run yet!)
console.log('5');


// 24153
// 15243
// 12345

function getJoke(onSuccess, onFailure = console.log) {
    // this object is provided by the browser to let us do AJAX
    // AJAX stands for Asynchronous JavaScript and XML
    //   but what it means in practice is, HTTP requests via JavaScript.
    let xhr = new XMLHttpRequest();

    // define what to do as the request-response lifecycle proceeds
    xhr.addEventListener('readystatechange', () => {
        console.log(`readyState: ${xhr.readyState}`);

        // readyState starts at 0 and counts upwards
        if (xhr.readyState === 4) {
            // 4 means, we've received the response
            let responseJSON = xhr.response;
            console.log(responseJSON);

            // HTTP response status 200-299 indicates success.
            if (xhr.status >= 200 && xhr.status < 300) {
                // responseJSON should contain the data I requested.
                console.log('success');

                // JSON.parse to deserialize JSON.
                // JSON.stringify to serialize JSON.

                let responseObj = JSON.parse(responseJSON);
                let text = responseObj.value.joke;
                onSuccess(text);
            } else {
                // some kind of error (e.g. 404 not found)
                // responseJSON should contain details about error
                console.log('failure');
                if (onFailure !== undefined) {
                    onFailure(responseJSON);
                }
            }
        }
    });

    // set up the request to be made
    xhr.open('get', 'http://api.icndb.com/jokes/random/');

    // send the request
    xhr.send();
}
