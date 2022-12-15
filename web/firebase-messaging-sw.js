

importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyD8gzRPSV18b--gAsyifjtIMAPsOn5JyDc',
    appId: '1:525737552936:web:65d7462abe74f6a05ed91d',
    messagingSenderId: '525737552936',
    projectId: 'tutorial-flutter-620bb',
    authDomain: 'tutorial-flutter-620bb.firebaseapp.com',
    storageBucket: 'tutorial-flutter-620bb.appspot.com',
    measurementId: 'G-DC9XZH3PR7',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});