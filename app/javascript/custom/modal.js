export function openModal(url) {
  const modal = document.getElementById('image-modal');
  const modalImg = document.getElementById('modal-image');
  modal.style.display = "block";
  modalImg.src = url;
}

export function closeModal() {
  const modal = document.getElementById('image-modal');
  modal.style.display = "none";
}

// 有効期限モーダル用
export function openExpiryModal() {
  const modal = document.getElementById('expiry-modal');
  modal.style.display = "block";
}

export function closeExpiryModal() {
  const modal = document.getElementById('expiry-modal');
  modal.style.display = "none";
}

// モーダル外クリックで閉じる
window.addEventListener("click", function(event) {
  const modal = document.getElementById('expiry-modal');
  if (event.target === modal) {
    modal.style.display = "none";
  }
});