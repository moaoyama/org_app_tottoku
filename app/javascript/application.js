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
  // === ファイルアップロード関連の処理 ===
  const form = document.getElementById("upload-form");
  const fileInput = document.getElementById("auto-upload-input");
  const fileBtn = document.getElementById("select-file-btn");
  const fileNameSpan = document.getElementById("file-name");

  if (form && fileInput) {
    form.addEventListener("submit", (event) => {
      if (!fileInput.files || fileInput.files.length === 0) {
        event.preventDefault();
        alert("ファイルが選択されていません");
      } else {
        // 送信後に input をクリア
        setTimeout(() => {
          if (fileInput) fileInput.value = null;
          if (fileNameSpan) fileNameSpan.textContent = "選択されていません";
          // カメラ入力もクリア
          const cameraInput = document.getElementById("camera-input");
          if (cameraInput) cameraInput.value = null;
        }, 0);
        }
    });
  } 

  // 「ファイルを選択」ボタンをクリックしたら input をクリックする
  if (fileBtn && fileInput) {
    fileBtn.addEventListener("click", () => {
      fileInput.click();
      });
    // 選択したファイル名を表示
    fileInput.addEventListener("change", () => {
      if (fileInput.files.length > 0) {
        const names = Array.from(fileInput.files).map(f => f.name).join(", ");
        fileNameSpan.textContent = names;
      } else {
        fileNameSpan.textContent = "選択されていません";
      }
    });
  }

  // === カメラ撮影 → 即アップロード ===
  const cameraInput = document.getElementById("camera-input");
  if (cameraInput && form) {
    cameraInput.addEventListener("change", async () => {
      if (cameraInput.files.length > 0) {
        const file = cameraInput.files[0];
        try {
          await resizeAndUpload(file, form); //リサイズ後に送信
          alert("写真をアップロードしました！");
        } catch (err) {
          console.error(err);
          alert("アップロードに失敗しました");
        }
      }
    });
  }
    
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
  const guestModal = document.getElementById('guest-modal');
  // 「ためしてみる」ボタンにクリックイベントを追加
  if (openGuestButton) {
    openGuestButton.addEventListener('click', () => {
      openGuestModal();
    });
  }

  // === Devise 登録フォームのエラーフラッシュ閉じる処理 ===
  document.addEventListener("click", (e) => {
    if (e.target && e.target.classList.contains("close-btn")) {
      const container = e.target.closest(".closeable-error");
      if (container) container.remove();
      }
    });

  // 閉じるボタンにクリックイベントを追加
  if (closeGuestButton) {
    closeGuestButton.addEventListener('click', () => {
      closeGuestModal();
    });
  }
});

function previewImage(event) {
  const files = event.target.files;
  const container = document.getElementById('preview-container');

  if (!container) return; // コンテナが存在しない場合は何もしない

  for (const file of files) {
    const reader = new FileReader();
    reader.onload = function(e) {
      const img = document.createElement('img');
      img.src = e.target.result;
      img.style.width = '80px';
      img.style.height = '80px';
      img.style.objectFit = 'cover';
      img.style.margin = '8px';
      container.appendChild(img);
    };
    reader.readAsDataURL(file);
  }
}