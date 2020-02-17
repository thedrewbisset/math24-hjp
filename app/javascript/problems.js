document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll("#solution input").forEach(item => {
    item.addEventListener('click', event => {
      document.querySelector('.alert').hidden = true;
    });
  });
});
