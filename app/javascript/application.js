// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
import "controllers"
import "./custom/expiry_modal"
import { openModal, closeModal } from "./custom/modal.js";
window.openModal = openModal;
window.closeModal = closeModal;

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

document.addEventListener("turbo:load", () => {
  const input = document.getElementById("auto-upload-input");
  const form  = document.getElementById("image-upload-form");
  const previewArea = document.getElementById("preview-area");

  if (!input || !form || !previewArea) return;

  input.addEventListener("change", () => {
    if (input.files.length > 0) {
      form.requestSubmit(); // Ajaxで送信
    }
  });
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