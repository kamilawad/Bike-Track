const io = require('socket.io-client');

const SERVER_URL = process.env.SOCKET_URL;
const RECIPIENT_USER_ID = process.env.USER2_ID;

const socket = io(SERVER_URL, {
  auth: {
    userId: RECIPIENT_USER_ID,
  },
});