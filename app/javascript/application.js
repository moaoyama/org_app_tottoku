// app/javascript/application.js

// Import mapで定義したモジュールを読み込む
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
import "controllers"
import { openModal, closeModal, openExpiryModal, closeExpiryModal, openGuestModal, closeGuestModal } from "./custom/modal.js";

Rails.start();

window.openModal = openModal;
window.closeModal = closeModal;
window.openExpiryModal = openExpiryModal;
window.closeExpiryModal = closeExpiryModal;
window.openGuestModal = openGuestModal;
window.closeGuestModal = closeGuestModal;


function previewImage(event) {
  const files = event.target.files;
  const container = document.getElementById('preview-container');

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

document.addEventListener("turbo:load", () => {
  const input = document.getElementById("auto-upload-input");
  const form  = document.getElementById("upload-form");
  const fileNameDisplay = document.getElementById("file-name");

  if (!input || !form || !fileNameDisplay) return;

  // ファイルが選択されたときの処理
  input.addEventListener("change", () => {
    if (input.files.length > 0) {
      // ファイル名を表示
      const fileNames = Array.from(input.files).map(file => file.name).join(', ');
      fileNameDisplay.textContent = fileNames;

      // ファイルが選択されたら自動でフォームを送信
    } else {
      // ファイルが選択されていない場合
      fileNameDisplay.textContent = '選択されていません';
    }
  });
});

// フラッシュメッセージの処理
document.addEventListener("turbo:load", () => {
  const flashMessages = document.querySelectorAll(".flash");

  flashMessages.forEach((msg) => {
    setTimeout(() => {
      msg.style.transition = "opacity 0.5s ease";
      msg.style.opacity = "0";
      setTimeout(() => {
        msg.remove();
      }, 500); // フェードアウト後にDOMから削除
    }, 3000); // 3秒後に消える
  });
});

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('.rails_admin .sidebar li a span').forEach(span => {
    span.replaceWith(span.textContent);
  });
});
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('.rails_admin .sidebar li a span').forEach(span => {
    span.replaceWith(span.textContent);
  });
});

document.addEventListener('turbo:load', () => {
  const flash = document.getElementById('error-flash');
  if (flash) {
    setTimeout(() => {
      flash.style.opacity = 0;
      // 1秒後にDOMから削除
      setTimeout(() => {
        flash.remove();
      }, 1000);
    }, 3000); // 3秒後にフェードアウト開始
  }
});