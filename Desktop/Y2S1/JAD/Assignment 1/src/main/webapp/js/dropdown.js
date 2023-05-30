const dropdowns = document.querySelectorAll('.dropdown');


dropdowns.forEach(dropdown => {
  const select = dropdown.querySelector('.select');
  const caret = dropdown.querySelector('.caret');
  const menu = dropdown.querySelector('.menu');
  const options = dropdown.querySelectorAll('.menu li');
  const selected = dropdown.querySelector('.selected');
  
  select.addEventListener('click', () => {
    
    select.classList.toggle('select-clicked');
    
    caret.classList.toggle('caret-rotate');
    
    menu.classList.toggle('menu-open');
  });

 
  options.forEach(option => {
    
    option.addEventListener('click', () => {
      if (option.classList.contains('active2')) {
        option.classList.remove('active2');
        selected.innerText = "Genre"
      } else {
        //Remove active class fro
        option.classList.add('active2');
      }
    });
  });
});