// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
import "controllers"

Rails.start();

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

document.addEventListener("DOMContentLoaded", function () {
  const fileInput = document.getElementById("auto-upload-input");
  const previewArea = document.getElementById("preview-area");
  const form = document.getElementById("image-upload-form");

  if (fileInput) {
    fileInput.addEventListener("change", function (event) {
      const files = event.target.files;

      // プレビューエリアを一度クリア
      previewArea.innerHTML = "";

      if (files.length > 0) {
        Array.from(files).forEach((file) => {
          if (file.type.startsWith("image/")) {
            const reader = new FileReader();

            reader.onload = function (e) {
              const img = document.createElement("img");
              img.src = e.target.result;
              img.className = "thumbnail";
              previewArea.appendChild(img);
            };

            reader.readAsDataURL(file);
          }
        });

        // フォーム自動送信 & ページを少し遅れてリロード
        form.submit();
        setTimeout(() => {
          window.location.reload();
        }, 1000); // 1秒待ってからリロード（調整可）
      }
    });
  }
});

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