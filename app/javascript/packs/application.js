require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

document.addEventListener("DOMContentLoaded", function() {
  const totalCarsElement = document.getElementById("total-cars");
  const totalCarsAvailableElement = document.getElementById("total-cars-available");

  totalCarsElement.addEventListener("click", () => redirectTo(totalCarsElement));
  totalCarsAvailableElement.addEventListener("click", () => redirectTo(totalCarsAvailableElement));

  function redirectTo(element) {
    const url = element.getAttribute("data-url");
    window.location.href = url;
  }
});

function initMap() {
  const latitudeElement = document.getElementById('latitude');
  const longitudeElement = document.getElementById('longitude');

  if (latitudeElement && longitudeElement) {
    const latitude = parseFloat(latitudeElement.value);
    const longitude = parseFloat(longitudeElement.value);
    const location = { lat: latitude, lng: longitude };

    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: location,
    });

    new google.maps.Marker({
      position: location,
      map: map,
      title: "Lieu du parking",
    });
  }
}

window.initMap = initMap;

document.addEventListener('DOMContentLoaded', function() {
  var showHideChauffeurCheckbox = document.getElementById('showHideChauffeur');
  var chauffeurSelect = document.getElementById('chauffeurSelect');

  showHideChauffeurCheckbox.addEventListener('change', function() {
    chauffeurSelect.style.display = this.checked ? 'block' : 'none';
  });

  var lastRefreshTime = localStorage.getItem('lastRefreshTime');
  var currentTime = new Date().getTime();
  var refreshInterval = 5000;

  if (!lastRefreshTime || currentTime - lastRefreshTime > refreshInterval) {
    localStorage.setItem('lastRefreshTime', currentTime);
    setTimeout(() => window.location.reload(), 100);
  }
});