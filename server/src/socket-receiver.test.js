const io = require('socket.io-client');

const SERVER_URL = 'http://localhost:3000/chat';
const RECIPIENT_USER_ID = '663d7123aaafc2eab3b8b5a0';

const socket = io(SERVER_URL, {
  auth: {
    userId: RECIPIENT_USER_ID,
  },
});

socket.on('connect', () => {
    console.log('Connected to the server.');
  
    const chatId = '66406fcdccbd803409b21468';
    const content = 'Hello from the recipient!';
  
    socket.emit('sendMessage', { chatId, content });
});
  
socket.on('newMessage', (message) => {
    try {
        console.log('Received a new message:', message);
    } catch (error) {
        console.error('An error occurred while handling a new message:', error);
    }
});

socket.on('disconnect', () => {
    console.log('Disconnected from the server.');
});