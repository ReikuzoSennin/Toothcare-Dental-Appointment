const buttonEnter = document.querySelectorAll('.btn-enter');
const formPage = document.querySelector(".form-page");
const formWrapperOne = document.querySelector(".form-wrapper-one");
const formWrapperTwo = document.querySelector(".form-wrapper-two");
const slideMessage = document.querySelector(".slide-one");
const form = sessionStorage.getItem("openedForm");

function handleButtonEnter() {
    if (formPage.classList.contains("slide-move")) {
        formPage.classList.remove("slide-move");
        formWrapperOne.classList.remove("form-wrapper-hidden");
        formWrapperTwo.classList.add('form-wrapper-hidden');
        slideMessage.classList.remove('slide-move');
        sessionStorage.setItem("openedForm","register");
    } else {
        formPage.classList.add('slide-move');
        formWrapperOne.classList.add('form-wrapper-hidden');
        formWrapperTwo.classList.remove("form-wrapper-hidden");
        slideMessage.classList.add('slide-move');
        sessionStorage.setItem("openedForm","login");
    }
}
function openedForm() {
    if (form=="register") {
        formPage.classList.remove("slide-move");
        formWrapperOne.classList.remove("form-wrapper-hidden");
        formWrapperTwo.classList.add('form-wrapper-hidden');
        slideMessage.classList.remove('slide-move');
    } else if (form=="login") {
        formPage.classList.add('slide-move');
        formWrapperOne.classList.add('form-wrapper-hidden');
        formWrapperTwo.classList.remove("form-wrapper-hidden");
        slideMessage.classList.add('slide-move');
    }
}
window.onload = openedForm;
buttonEnter.forEach(button => {
    button.addEventListener('click', handleButtonEnter);
});