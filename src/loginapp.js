// Import the functions you need from the SDKs you need

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional

// var firebase = require("./")
import { auth } from "firebase";

window.onload = function () {
  render();
};
function render() {
  window.recaptchaVerifier = new auth.RecaptchaVerifier("recaptcha-container");
  recaptchaVerifier.render();
}

function codeverify() {
  var code = document.getElementById("verificationCode").value;
  window.confirmationResult
    .confirm(code)
    .then(function (result) {
      alert("Successfully registered");
      var user = result.user;
      console.log(user);
    })
    .catch(function (error) {
      alert(error.message);
    });
}

function phoneAuth() {
  var number = document.getElementById("number").value;

  auth()
    .signInWithPhoneNumber(number, window.recaptchaVerifier)
    .then(function (confirmationResult) {
      window.confirmationResult = confirmationResult;
      console.log(confirmationResult);
      alert("Message sent");
    })
    .catch(function (error) {
      console.log(error.message);
    });
}

document.getElementById("getcode").addEventListener("click", phoneAuth);
document.getElementById("verifycode").addEventListener("click", codeverify);
