// Control de mando a distancia para Smart TV (D-Pad)
document.addEventListener('keydown', (e) => {
  const focusables = Array.from(document.querySelectorAll('[tabindex="0"], a, button, input'));
  const index = focusables.indexOf(document.activeElement);

  if (e.key === 'Escape' || e.key === 'Backspace' || e.keyCode === 10009 || e.keyCode === 461) {
    if (window.location.pathname.indexOf('index.html') === -1 && window.location.pathname !== '/') {
      window.location.href = 'index.html';
    }
  }
});
