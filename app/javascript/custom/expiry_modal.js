document.addEventListener("turbo:load", () => {
  const openBtn = document.getElementById("expiry-button");
  const modal = document.getElementById("expiry-modal");
  const closeBtn = document.getElementById("expiry-close");
  const cancelBtn = document.querySelector(".cancel-btn");

  if (!openBtn || !modal || !closeBtn) return;

  // モーダルを開く
  openBtn.addEventListener("click", () => {
    modal.style.display = "flex";
  });

  // モーダルを閉じる
  closeBtn.addEventListener("click", () => {
    modal.style.display = "none";
  });

  // モーダル外をクリックしたら閉じる
  window.addEventListener("click", (event) => {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  });
});

document.querySelectorAll(".expiry-text").forEach((el) => {
  el.addEventListener("click", () => {
    const radioId = el.getAttribute("data-radio");
    const radio = document.getElementById(radioId);
    if (radio) {
      radio.checked = true;
    }
  });
});