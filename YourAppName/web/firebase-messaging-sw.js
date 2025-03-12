importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCJ7G3BQmwI6koeECdtn5Wl21BceZk_oyQ",
  authDomain: "primevideoapp-43bf6.firebaseapp.com",
  projectId: "primevideoapp-43bf6",
  storageBucket: "primevideoapp-43bf6.appspot.com",
  messagingSenderId: "346606981660",
  appId: "1:346606981660:web:455544c2a46ec6152fc5d9",
  measurementId: "G-LSVW6BYR27"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

messaging.onBackgroundMessage(messaging, (payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
});
