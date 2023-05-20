//Name            : Chia Jun Hao, Javier
//Class           : DIT/FT/1B/03
//Group           : -
//Admission Number: 2227931

function addedAlert() {
  $(".added").removeClass("hide");
  $(".added").addClass("show");
  $(".added").addClass("showAlert");
  setTimeout(function () {
    $(".added").addClass("hide");
    $(".added").removeClass("show");
  }, 1000);
}

function login2Alert() {
  $(".loginAlert").removeClass("hide");
  $(".loginAlert").addClass("show");
  $(".loginAlert").addClass("showAlert");
  setTimeout(function () {
    $(".loginAlert").addClass("hide");
    $(".loginAlert").removeClass("show");
  }, 1000);
}

function successAlert() {
  $(".success").removeClass("hide");
  $(".success").addClass("show");
  $(".success").addClass("showAlert");
  setTimeout(function () {
    $(".success").addClass("hide");
    $(".success").removeClass("show");
  }, 1000);
}

function notFountAlert() {
  $(".notFound").removeClass("hide");
  $(".notFound").addClass("show");
  $(".notFound").addClass("showAlert");
  setTimeout(function () {
    $(".notFound").addClass("hide");
    $(".notFound").removeClass("show");
  }, 1000);
}

function loginAlert() {
  $(".loggedIn").removeClass("hide");
  $(".loggedIn").addClass("show");
  $(".loggedIn").addClass("showAlert");
  setTimeout(function () {
    $(".loggedIn").addClass("hide");
    $(".loggedIn").removeClass("show");
  }, 800);
}

function noEntriesAlert() {
  $(".enter").removeClass("hide");
  $(".enter").addClass("show");
  $(".enter").addClass("showAlert");
  setTimeout(function () {
    $(".enter").addClass("hide");
    $(".enter").removeClass("show");
  }, 800);
}

function duplicateEmailAlert() {
  $(".dupEmail").removeClass("hide");
  $(".dupEmail").addClass("show");
  $(".dupEmail").addClass("showAlert");
  setTimeout(function () {
    $(".dupEmail").addClass("hide");
    $(".dupEmail").removeClass("show");
  }, 800);
}

function logoutAlert() {
  $(".loggedOut").removeClass("hide");
  $(".loggedOut").addClass("show");
  $(".loggedOut").addClass("showAlert");
  setTimeout(function () {
    $(".loggedOut").addClass("hide");
    $(".loggedOut").removeClass("show");
  }, 800);
}

function loginToLogout() {
  if (sessionStorage.getItem("showLogoutAlert") === "true") {
    logoutAlert();
    sessionStorage.removeItem("showLogoutAlert");
  }
  if (
    localStorage.getItem("token") !== null &&
    localStorage.getItem("userType") !== null
  ) {
    var btnLogin = document.getElementById("btnLogin");
    btnLogin.innerHTML = "Logout";
    btnLogin.onclick = function () {
      btnLogin.innerHTML = "Login";
      // Clear the token and userType from local storage
      localStorage.removeItem("token");
      localStorage.removeItem("userType");
      localStorage.removeItem("storeid");
      localStorage.removeItem("id");
      $(".wrapper").removeClass("active-popup");
      sessionStorage.setItem("showLogoutAlert", "true");

      window.location.assign("http://localhost:3000/index.html");
    };
  }
}

function onSearch() {
  
}

function cart() {
  
}

function onCheckoutClick() {
	
}

function onAdminClick() {
  
}