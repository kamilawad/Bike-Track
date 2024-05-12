const io = require('socket.io-client');

const SERVER_URL = process.env.SOCKET_URL;
const RECIPIENT_USER_ID = process.env.USER2_ID;

const socket = io(SERVER_URL, {
  auth: {
    userId: RECIPIENT_USER_ID,
  },
});

socket.on('connect', () => {
    console.log('Connected to the server.');
  
    const chatId = process.env.CHAT_ID;
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