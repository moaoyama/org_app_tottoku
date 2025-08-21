// app/javascript/application.js

// Import mapで定義したモジュールを読み込む
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/ujs" // @rails/ujsを読み込む
import "custom/modal" // modal.js を読み込む
import "hamburger_toggle" // hamburger_toggle.jsを読み込む

// Turboを使用しているため、turbo:loadイベントに統一
document.addEventListener("turbo:load", () => {
  // === ファイルアップロード関連の処理 ===
  const input = document.getElementById("auto-upload-input");
  const form = document.getElementById("upload-form");
  const fileNameDisplay = document.getElementById("file-name");

  if (input && fileNameDisplay) {
    input.addEventListener("change", () => {
      if (input.files.length > 0) {
        const fileNames = Array.from(input.files).map(file => file.name).join(', ');
        fileNameDisplay.textContent = fileNames;
      } else {
        fileNameDisplay.textContent = '選択されていません';
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
