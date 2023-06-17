const dropdowns = document.querySelectorAll('.dropdown');

dropdowns.forEach(dropdown => {
  const select = dropdown.querySelector('.select');
  const caret = dropdown.querySelector('.caret');
  const menu = dropdown.querySelector('.menu');
  const options = dropdown.querySelectorAll('.menu li');
  const selected = dropdown.querySelector('.selected');
  const selectedGenres = []; // Array to store selected genre names

  select.addEventListener('click', () => {
    select.classList.toggle('select-clicked');
    caret.classList.toggle('caret-rotate');
    menu.classList.toggle('menu-open');
  });

  options.forEach(option => {
    option.addEventListener('click', () => {
      const genreId = option.getAttribute('value');
      const genreName = option.innerText;

      if (option.classList.contains('active2')) {
        option.classList.remove('active2');
        selectedGenres.splice(selectedGenres.indexOf(genreName), 1); // Remove unselected genre from the array
      } else {
        option.classList.add('active2');
        selectedGenres.push(genreName); // Add selected genre to the array
      }

      // Update the display with selected genres
      const existingGenres = selected.innerText.split(', '); // Get the existing selected genres

      if (selectedGenres.length > 0) {
        const newGenres = selectedGenres.filter(genre => !existingGenres.includes(genre)); // Filter out already selected genres
        const displayText = existingGenres.concat(newGenres).join(', '); // Combine existing and new genres
        const maxLength = selected.clientWidth > 320 ? 400 : 20; // Adjust the maximum length based on the div size
        selected.innerText = truncateText(displayText, maxLength);
      } else {
        selected.innerText = 'Genre';
      }
    });
  });
});

// Function to truncate text and add ellipsis if it exceeds the specified length
function truncateText(text, maxLength) {
  if (text.length > maxLength) {
    return text.substring(0, maxLength) + '...';
  }
  return text;
}
