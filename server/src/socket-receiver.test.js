const io = require('socket.io-client');

const SERVER_URL = 'http://localhost:3000/chat';
const RECIPIENT_USER_ID = '6644e75506c40d7d61553e50';

const socket = io(SERVER_URL, {
  auth: {
    userId: RECIPIENT_USER_ID,
  },
});

socket.on('connect', () => {
    console.log('Connected to the server.');
  
    const chatId = '6644e996ffd67d0303986fef';
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