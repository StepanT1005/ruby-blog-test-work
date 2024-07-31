document.addEventListener("turbo:load", function() {
    showNoticeAndAlert();
  });
  
  function showNoticeAndAlert() {
    const notice = document.querySelector(".notice");
    const alert = document.querySelector(".alert");
  
    if (notice && notice.innerText.trim() !== "") {
      notice.style.display = "block";
      setTimeout(() => {
        notice.style.display = "none";
      }, 5000);
    }
  
    if (alert && alert.innerText.trim() !== "") {
      alert.style.display = "block";
      setTimeout(() => {
        alert.style.display = "none";
      }, 5000);
    }
  }
  