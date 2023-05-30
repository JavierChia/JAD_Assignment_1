const wrapper = document.querySelector('.wrapper');
const wrapperContainer = document.querySelector('.wrapper-container')
const descContainer = document.querySelector('.description-container');
const loginLink = document.querySelector('.login-link');
const registerLink = document.querySelector('.register-link');
const openLogin = document.querySelector('.btnLogin')
const closeLogin = document.querySelector('.icon-close')

registerLink.addEventListener('click', () => {
    wrapper.classList.add('active');
})

loginLink.addEventListener('click', () => {
    wrapper.classList.remove('active');
})

openLogin.addEventListener('click', () => {
    wrapper.classList.add('active-popup');
    wrapperContainer.classList.add("active-popup");
    descContainer.classList.add('blur');
})

closeLogin.addEventListener('click', () => {
    wrapper.classList.remove('active-popup');
    wrapperContainer.classList.remove("active-popup")
    descContainer.classList.remove('blur');
})

