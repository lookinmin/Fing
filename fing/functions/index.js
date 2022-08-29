const functions = require("firebase-functions");
const admin = require("firebase-admin");



var serviceAccount = require("./fing-firebase-cbnu-firebase-adminsdk-389by-13a4927f31.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
  // // Create and Deploy Your First Cloud Functions
  // // https://firebase.google.com/docs/functions/write-firebase-functions
  //
  exports.createCustomToken = functions.region("asia-northeast3").https.onRequest(async (request, response) => {
    const user = request.body;
  
    const uid = 'kakao:'+ user.uid;
    const updateParams = {
      email: user.email,
      photoURL: user.photoURL,
      displayName: user.displayName,
    };
    try {
      await admin.auth().updateUser(uid, updateParams);
    } catch (e) {
      updateParams["uid"] = uid;
      await admin.auth().createUser(updateParams);
    }
  
    const token = await admin.auth().createCustomToken(uid);

    response.send(token);
  });