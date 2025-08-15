document.addEventListener("turbo:load", () => {
  const openBtn = document.getElementById("expiry-button");
  const modal = document.getElementById("expiry-modal");
  const closeBtn = document.getElementById("expiry-close");

  if (!openBtn || !modal || !closeBtn) return;

  // モーダルを開く
  openBtn.addEventListener("click", () => {
    modal.style.display = "block";
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