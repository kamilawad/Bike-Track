const io = require('socket.io-client');

const SERVER_URL = process.env.SOCKET_URL;
const USER_ID = process.env.USER1_ID;

const socket = io(SERVER_URL, {
    auth: {
        userId: USER_ID,
    },
});

socket.on('connect', () => {
    console.log('Connected to the server.');

    const chatId = process.env.CHAT_ID;
    const content = 'Hello from sender';
    socket.emit('sendMessage', { chatId, content });
});

socket.on('newMessage', (message) => {
    try {
        console.log('Received a new message:', message);
    } catch (error) {
        console.error('error occurred while handling a new message:', error);
    }
});

socket.on('userConnected', (data) => {
    try {
        console.log('A user has connected:', data);
    } catch (error) {
        console.error('error occurred while handling a user connection:', error);
    }
});

socket.on('userDisconnected', (data) => {
    try {
        console.log('A user has disconnected:', data);
    } catch (error) {
        console.error('error occurred while handling a user disconnection:', error);
    }
});