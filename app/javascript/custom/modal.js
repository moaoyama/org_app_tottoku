export function openModal(url) {
  const modal = document.getElementById('image-modal');
  const modalImg = document.getElementById('modal-image');
  if (modal && modalImg) {
    modal.style.display = "block";
    modalImg.src = url;
  }
}

export function closeModal() {
  const modal = document.getElementById('image-modal');
  if (modal) {
    modal.style.display = "none";
  }
}

// 有効期限モーダル用
export function openExpiryModal() {
  const modal = document.getElementById('expiry-modal');
  if (modal) {
    modal.style.display = "block";
  }
}

export function closeExpiryModal() {
  const modal = document.getElementById('expiry-modal');
  if (modal) {
    modal.style.display = "none";
  }
}

// ゲストログインモーダル用
export function openGuestModal() {
  const modal = document.getElementById('guest-modal');
  if (modal) {
    modal.style.display = 'block';
  }
}
export function closeGuestModal() {
  const modal = document.getElementById('guest-modal');
  if (modal) {
    modal.style.display = 'none';
  }
}