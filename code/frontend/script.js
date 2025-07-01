function setCookie(name, value, days) {
    const expires = new Date(Date.now() + days * 864e5).toUTCString();
    document.cookie = name + '=' + encodeURIComponent(value) + '; expires=' + expires + '; path=/';
  }
  
  function getCookie(name) {
    return document.cookie.split('; ').reduce((r, v) => {
      const parts = v.split('=');
      return parts[0] === name ? decodeURIComponent(parts[1]) : r
    }, '');
  }
  
  function getWeatherIcon(condition) {
    const icons = {
      'Sonnig': '☀️',
      'Regen': '🌧️',
      'Fleckiger Regen': '🌦️',
      'Fleckiger Regen in der Nähe': '🌦️',
      'Wolkig': '☁️',
      'Teilweise bewölkt': '⛅',
      'Schnee': '❄️',
      'Gewitter': '⛈️',
      'Nebel': '🌫️'
    };
    return icons[condition] || '🌤️';
  }
  
  function loadWeather() {
    const city = document.getElementById("city-input").value.trim();
    if (!city) return;
  
    setCookie("lastCity", city, 30); 
  
    document.getElementById("weather").innerHTML = `
      <div class="current-weather">
        <h2 class="weather-title">Lade Daten für ${city}...</h2>
      </div>
    `;
    document.getElementById("forecast").innerHTML = '<li>Lade Vorhersage...</li>';
    document.getElementById("ml-forecast").innerHTML = '<li>Lade Vorhersage...</li>';
  
    fetch(`/api/weather?q=${encodeURIComponent(city)}`, {
      headers: { "X-Internal-Key": "letmein" }
    })
      .then(res => res.json())
      .then(data => {
        if (data.error) {
          document.getElementById("weather").innerHTML = `
            <div class="current-weather">
              <p class="error-message">${data.error}</p>
            </div>
          `;
          return;
        }
  
        const forecastHtml = data.forecast.map(day => `
          <li class="forecast-item">
            <span>${day.day}</span>
            <span>
              <span class="temp">${day.temp}</span>
              <span class="condition">${getWeatherIcon(day.condition)} ${day.condition}</span>
            </span>
          </li>
        `).join("");
  
        document.getElementById("weather").innerHTML = `
          <div class="current-weather">
            <h2 class="weather-title">${data.location}</h2>
            <p class="weather-now">
              <span class="temp">${data.temperature}</span>
              <span>${getWeatherIcon(data.condition)} ${data.condition}</span>
            </p>
          </div>
        `;
        
        document.getElementById("forecast").innerHTML = forecastHtml;
      })
      .catch(() => {
        document.getElementById("weather").innerHTML = `
          <div class="current-weather">
            <p class="error-message">Fehler beim Laden der Wetterdaten.</p>
          </div>
        `;
      });
  
    fetch(`/ml/forecast?q=${encodeURIComponent(city)}`, {
      headers: { "X-Internal-Key": "letmein" }
    })
      .then(res => res.json())
      .then(mlData => {
        if (mlData.predicted) {
          const mlForecastHtml = mlData.predicted.map(entry => `
            <li class="forecast-item">
              <span>${entry.day}</span>
              <span class="temp">${entry.predicted_temp}</span>
            </li>
          `).join("");
          document.getElementById("ml-forecast").innerHTML = mlForecastHtml;
        } else {
          document.getElementById("ml-forecast").innerHTML = "<li>Keine ML-Daten verfügbar.</li>";
        }
      })
      .catch(() => {
        document.getElementById("ml-forecast").innerHTML = "<li>ML-Vorhersage nicht verfügbar.</li>";
      });
  }
  
  document.addEventListener("DOMContentLoaded", () => {
    const lastCity = getCookie("lastCity") || "Zürich";
    document.getElementById("city-input").value = lastCity;
    loadWeather();
  });
