// app/javascript/application.js

// Import mapで定義したモジュールを読み込む
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/ujs" // @rails/ujsを読み込む
import "custom/modal" // modal.js を読み込む
import "hamburger_toggle" // hamburger_toggle.jsを読み込む
import { openGuestModal, closeGuestModal } from "custom/modal";
import { resizeAndUpload } from "custom/image_upload";

// Turboを使用しているため、turbo:loadイベントに統一
document.addEventListener("turbo:load", () => {
  setupUploadButtons(); // ここでバインド
  
  // === フラッシュメッセージ関連の処理 ===
  const flashMessages = document.querySelectorAll(".flash");
  flashMessages.forEach((msg) => {
    setTimeout(() => {
      msg.style.transition = "opacity 0.5s ease";
      msg.style.opacity = "0";
      setTimeout(() => {
        msg.remove();
      }, 500);
    }, 3000);
  });  

  // === Rails Adminのサイドバー関連の処理 ===
  document.querySelectorAll('.rails_admin .sidebar li a span').forEach(span => {
    span.replaceWith(span.textContent);
  });

  // === ゲストモーダル関連の処理 ===
  const openGuestButton = document.getElementById('expiry-button');
  const closeGuestButton = document.getElementById('guest-close');
  
  // 「ためしてみる」ボタンにクリックイベントを追加
  if (openGuestButton) openGuestButton.addEventListener('click', openGuestModal);
  if (closeGuestButton) closeGuestButton.addEventListener('click', closeGuestModal);

  // === Devise 登録フォームのエラーフラッシュ閉じる処理 ===
  document.addEventListener("click", e => {
    if (e.target.classList.contains("close-btn")) {
      const container = e.target.closest(".closeable-error");
      if (container) container.remove();
      }
    });
});

function setupUploadButtons() {
  const form = document.getElementById("upload-form");
  const fileInput = document.getElementById("auto-upload-input");
  const fileBtn = document.getElementById("select-file-btn");
  const fileNameSpan = document.getElementById("file-name");
  const cameraInput = document.getElementById("camera-input");

  if (!form || !fileInput || !fileBtn || !fileNameSpan) return;

  if (fileBtn.dataset.bound) return;
  fileBtn.dataset.bound = "true";

  fileBtn.addEventListener("click", () => fileInput.click());

  fileInput.addEventListener("change", () => {
    const names = fileInput.files.length > 0
      ? Array.from(fileInput.files).map(f => f.name).join(", ")
      : "選択されていません";
    fileNameSpan.textContent = names;

    previewImage(fileInput.files);
  });

form.addEventListener("submit", event => {
    if (!fileInput.files || fileInput.files.length === 0) {
      event.preventDefault();
      alert("ファイルが選択されていません");
    } else {
      setTimeout(() => {
        fileInput.value = null;
        fileNameSpan.textContent = "選択されていません";
        if (cameraInput) cameraInput.value = null;
      }, 0);
    }
  });

  // カメラ撮影
  if (cameraInput) {
    cameraInput.addEventListener("change", async () => {
      if (cameraInput.files.length > 0) {
        previewImage(cameraInput.files);
        try {
          await resizeAndUpload(cameraInput.files[0], form);
          alert("写真をアップロードしました！");
        } catch (err) {
          console.error(err);
          alert("アップロードに失敗しました");
        }
      }
    });
  }
}

// プレビュー関数
function previewImage(files) {
  const container = document.getElementById('preview-container');
  if (!container) return;

  container.innerHTML = ""; // 前回のプレビューをクリア
  Array.from(files).forEach(file => {
    const reader = new FileReader();
    reader.onload = e => {
      const img = document.createElement('img');
      img.src = e.target.result;
      img.style.width = '80px';
      img.style.height = '80px';
      img.style.objectFit = 'cover';
      img.style.margin = '8px';
      container.appendChild(img);
    };
    reader.readAsDataURL(file);
  });
}