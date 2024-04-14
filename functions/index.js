/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");


// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBgjtxwV8kP2exiUFS_Al1rVPpPRumYprI",
  authDomain: "fir-functions12.firebaseapp.com",
  projectId: "fir-functions12",
  storageBucket: "fir-functions12.appspot.com",
  messagingSenderId: "914217963572",
  appId: "1:914217963572:web:c37f9845a8df3d8497fa61"
};



// Initialize Firebase
const app = initializeApp(firebaseConfig);
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
