require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

document.addEventListener("turbolinks:load", function() {
  const totalCarsElement = document.getElementById("total-cars");
  const totalCarsAvailableElement = document.getElementById("total-cars-available");

  function redirectTo(element) {
    const url = element.getAttribute("data-url");
    Turbolinks.visit(url);
  }

  if (totalCarsElement) {
    totalCarsElement.addEventListener("click", () => redirectTo(totalCarsElement));
  }

  if (totalCarsAvailableElement) {
    totalCarsAvailableElement.addEventListener("click", () => redirectTo(totalCarsAvailableElement));
  }

  var showHideChauffeurCheckbox = document.getElementById('showHideChauffeur');
  var chauffeurSelect = document.getElementById('chauffeurSelect');

  function toggleChauffeurSelect() {
    chauffeurSelect.style.display = showHideChauffeurCheckbox.checked ? 'block' : 'none';
  }

  toggleChauffeurSelect();

  showHideChauffeurCheckbox.addEventListener('change', toggleChauffeurSelect);
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
