# Weather app

This application was developed for the course Introduction to App Development with Flutter at Linnaeus University (1DV535, 7.5 credits) the summer of 2023. It is a Flutter application that provides users with up-to-date weather information fetched from [openweathermap.org](https://openweathermap.org).

## Features

- Location-based weather data using geolocation.
- Current weather display with details such as temperature, weather description, wind information, sunrise and sunset times.
- Forecast display showing weather predictions for the next five days in a three hour interval.

## Screenshots

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div>
    <img src="/my_app/assets/screenshots/home.png" alt="The home page" width="200"/>
    <p style="text-align: center;">Home Page</p>
  </div>
  <br>
  <div>
    <img src="/my_app/assets/screenshots/forecast.png" alt="The forecast screen" width="200"/>
    <p style="text-align: center;">Forecast Screen</p>
  </div>
  <br>
  <div>
    <img src="/my_app/assets/screenshots/forecast_collapsed.png" alt="The forecast screen with some days collapsed" width="200"/>
    <p style="text-align: center;">Forecast Screen  with some days Collapsed</p>
  </div>
  <br>
  <div>
    <img src="/my_app/assets/screenshots/about.png" alt="The about screen" width="200"/>
    <p style="text-align: center;">About Screen</p>
  </div>
</div>

## Compability

The app is designed to work smoothly across a range of devices. It has been successfully tested on **\_** in Android Stuidos emulator during development. While this device has been the primary focus when developing the app, it should perform well on other devices with similar specifications and operating system versions.

## Installation

1. Clone this repository
2. Navigate to the project directory
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Dependencies

Other than Flutter and Android Studio, the following dependencies are required:

- cupertino_icons: ^1.0.2
- go_router: ^10.0.0
- http: ^1.0.0
- geolocator: ^9.0.2
- permission_handler: ^10.4.3
- geocoding: ^2.1.0
- intl: ^0.18.1

## Usage

1. Launch the app.
2. The app will request location permissions. Grant the permissions to fetch accurate weather data.
3. The main screen displays the current weather information including temperature, description, wind information, and more.
4. Tap the icons in the bottom navigation bar to switch between screens.
5. The navigation screen shows the forecast for the upcoming five days, displayed in expandable tiles.
6. Tap about screen displays information about the app.

## Known Issues

- From time to time, there could be occurrences of an error associated with parsing information from JSON. This inconsistency seems to manifest particularly when the emulator has been active for an extended duration and mostly during night time. This suggests that the issue might not be related to the code itself. Interestingly, after restarting both the emulator and the computer following a substantial downtime, the code always runs error-free, even though no modifications have been made.
- Occasionally, there might be instances of an error related to location retrieval when switching between screens. Efforts have been made to pinpoint its cause, but it remains unknown due to its inconsistant nature. Though, it appears to be related to initializing a request while another is already in progress.
- The implementation of the navigation bar needs refinement. Currently, it is generated anew with the construction of each screen. It should be generated only once, when the app is started.
- The app currently relies on a deprecated geolocation service to obtain city names. While an attempt was made to utilize reverse geocoding for this purpose, issues arose with obtaining accurate data, which led to the decision to fall back on the deprecated functionality.
- The main screen currently does not display information about wind direction.
