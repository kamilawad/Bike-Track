const io = require('socket.io-client');

const SERVER_URL = 'http://localhost:3000/chat';
const USER_ID = '6644d85b8f5f43f7f0a5eac2';

const socket = io(SERVER_URL, {
    auth: {
        userId: USER_ID,
    },
});

socket.on('connect', () => {
    console.log('Connected to the server.');

    const chatId = '6644e996ffd67d0303986fef';
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