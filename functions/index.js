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
const functions = require('firebase-functions');
const admin = require('firebase-admin');

const axios = require('axios');





// Import the functions you need from the SDKs you need
//const { initializeApp } = require("firebase/app");
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

admin.initializeApp();
const db = admin.firestore();
const docRef = db.collection('Holiday').doc('UsHolidays');
const labref = db.collection('lab').doc('test');

//no idea how to get the API_KEY variable from dart into js; pretend this isn't here
const api_key = '6ejHzAidPCOiSeD1GyDUsAKSbob0Iwmx';

exports.pubsub = functions
                    .runWith({timeoutSeconds: 60, memory: "1GB"})
                    .pubsub
                    .schedule('Every 12 hours')
                    .onRun(async context => {
                      await axios.get('https://calendarific.com/api/v2/holidays?&api_key=' + api_key + '&country=US&day=$day&month=$month&year=$year', {params})
                      .then(response => {
                        const apiResponse = response.data;
                        docRef.set({
                          current: apiResponse,
                        })
                      }).catch(error => {
                        console.log(error);
                      });
                    })


  exports.readLab = onRequest({timeoutSeconds: 15, cors: true, maxInstances: 10},
  (request, response) => {
    labref.get().then((doc) => {
      if (doc.exists){
        
        response.send(doc.data());
        
      } else {
        logger.info("Document wasn't found...", {structuredData: true});
      }
    })
  });

  exports.flashBriefing = onRequest({timeoutSeconds: 15, cors: true, maxInstances: 10}, async (request, reponse) => {
    logger.info("flash briefing has been called!!", {structuredData: true});
  });

  exports.queryTest = onRequest({timeoutSeconds: 15, cors: true, maxInstances: 10}, (request, response) => {
    logger.info("Checking logs...", {structuredData: true});
    console.log(request.query)
    labref.set({
      current: request.query
    }).then(()=>{
      response.send("QueryTest Received")
    })
  });





// Initialize Firebase
//const app = initializeApp(firebaseConfig);
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
