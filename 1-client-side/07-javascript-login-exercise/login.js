// assignment: make it so if you fill the correct
// username and password, clicking "submit"
// will take you to index.html.

// tools:
// to navigate the browser to a new page:
//    window.location = "https://google.com"
//    window.location = "index.html"
// to get the value contained in an input element:
//    (element).value
// you'll want the form's "submit" event.
// you'll want to add an id to the form

document.addEventListener("DOMContentLoaded", () => {
    let form = document.getElementById("loginForm");

    form.addEventListener("submit", event => {
        // prevent the default "form submit" behavior
        // (sending data according to the "action" attr of the form)
        event.preventDefault();

        let username = document.getElementById("inputUsername").value;
        let password = document.getElementById("inputPassword").value;

        if (username === "Nick" && password === "revature") {
            window.location = "./index.html";
        } else {
            alert("Incorrect login!");
        }
    });
});
