const io = require('socket.io-client');

const SERVER_URL = process.env.SOCKET_URL;
const USER_ID = process.env.USER1_id;

const socket = io(SERVER_URL, {
    auth: {
        userId: USER_ID,
    },
});

socket.on('connect', () => {
    console.log('Connected to the server.');
});