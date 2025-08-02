document.addEventListener("DOMContentLoaded", () => {
  const toggle = document.getElementById("menu-toggle");
  const menu = document.getElementById("hamburger-menu");
  const menuClose = document.getElementById("menu-close");

  if (!toggle || !menu) return;

  toggle.addEventListener("click", () => {
    menu.classList.toggle("hidden");
  });

  if (menuClose) {
    menuClose.addEventListener("click", () => {
      menu.classList.add("hidden");
    });
  }

  document.addEventListener("click", (e) => {
    if (!menu.contains(e.target) && !toggle.contains(e.target)) {
      menu.classList.add("hidden");
    }
  });
});
