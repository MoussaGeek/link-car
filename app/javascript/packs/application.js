// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
function initMap() {
  const latitude = parseFloat(document.getElementById('latitude').value);
  const longitude = parseFloat(document.getElementById('longitude').value);

  const location = { lat: latitude, lng: longitude };

  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 14,
    center: location,
  });

  const marker = new google.maps.Marker({
    position: location,
    map: map,
    title: "Lieu du parking",
  });
}

window.initMap = initMap;



document.addEventListener('DOMContentLoaded', function() {
  var showHideChauffeurCheckbox = document.getElementById('showHideChauffeur');
  var chauffeurSelect = document.getElementById('chauffeurSelect');

  showHideChauffeurCheckbox.addEventListener('change', function() {
      if (this.checked) {
          chauffeurSelect.style.display = 'block';
      } else {
          chauffeurSelect.style.display = 'none';
      }
  });

  // Check if the page was refreshed in the last 5 seconds
  var lastRefreshTime = localStorage.getItem('lastRefreshTime');
  var currentTime = new Date().getTime();
  var refreshInterval = 5000; // Set to the desired refresh interval in milliseconds

  if (!lastRefreshTime || currentTime - lastRefreshTime > refreshInterval) {
      // Reload the page if it hasn't been refreshed recently
      localStorage.setItem('lastRefreshTime', currentTime);
      setTimeout(function() {
          window.location.reload();
      }, 100); // Reload the page after a small delay
  }
});