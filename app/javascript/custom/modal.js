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
    modal.style.display = 'none';
  }
}
export function closeGuestModal() {
  const modal = document.getElementById('guest-modal');
  if (modal) {
    modal.style.display = 'none';
  }
}

// すべてのモーダルに共通するクリックイベントリスナー
document.addEventListener('DOMContentLoaded', () => {
  const guestModal = document.getElementById('guest-modal');
  const openGuestButton = document.getElementById('expiry-button');
  const closeGuestButton = document.getElementById('guest-close');

  if (openGuestButton && guestModal) {
    openGuestButton.addEventListener('click', openGuestModal);
  }

  if (closeGuestButton && guestModal) {
    closeGuestButton.addEventListener('click', closeGuestModal);
  }

  // 複数のモーダルに対応するため、モーダル外クリックイベントリスナーを分離
  window.addEventListener("click", (event) => {
    // ゲストモーダルを閉じる処理
    if (event.target === guestModal) {
      closeGuestModal();
    }
    // 他のモーダルにも同様に追加可能
    const expiryModal = document.getElementById('expiry-modal');
    if (event.target === expiryModal) {
      closeExpiryModal();
    }
  });
});