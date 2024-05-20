<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>

> A mobile app for tracking and planning bike routes and events, making it more enjoyale and easier for bike riders enthusiasts to engage in their favorite activity.
>
> Bike Track aims to bring bike riders together by providing a user-friendly platform where bike drivers can find new places with our route feature and makes every ride fun and social. We believe in enhancing the cycling experience by providing real-time tracking, efficient route planning, and fostering a community of cyclists.

### User Stories

### User

- As a user, I want to plan routes for my rides, so I can discover new biking trails and explore different areas.
- As a user, I want to join collaborative events, so I can participate in group rides and meet other cycling.
- As a user, I want to use the chat feature, so I can communicate with other users and share my experiences.
- As a user, I want to participate in event races and marathons, so I can challenge myself and compete with others.

### Organizer

- As an organizer, I want to create events on the app, so I can invite users to participate.
- As an organizer, I want to create room chats, so I can communicate with the event memebers.
- As an organizer, I want to manage chat rooms for my events, so I can ensure a well organized event.

<br><br>
<!-- Tech stack -->
<img src="./readme/title3.svg"/>

###  Bike Track is built using the following technologies:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- This project uses Provider for state management. Provider is a popular solution in the Flutter ecosystem. By using Provider, you can efficiently manage app-wide state, making data flow predictable and organized.
- The backend of Bike Track is developed using the [NestJS framework](https://docs.nestjs.com/). NestJS, built on top of Express.js, provides a structured and scalable architecture for APIs.
- To power live features like chat, and real-time tracking, Bike Track integrates [Socket.IO](https://socket.io/). Socket.IO enables seamless communication between clients and servers.
- Our app integrates the [Google Maps SDK](https://developers.google.com/maps/documentation), users can explore biking trails, discover new areas, and plan their rides effectively using detailed maps.

<br><br>
<!-- UI UX -->
<img src="./readme/title4.svg"/>


> We designed Bike Track using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.

- Project Figma design [figma](https://www.figma.com/design/7EXIgrAfR7oMNQCGds6CHq/Bike-Track?node-id=317-683&t=0OrgyyHj8OOd6srD-0)


### Mockups
| Onboarding screen  | Login Screen | Order Screen |
| ---| ---| ---|
| ![Landing](./readme/demo/onboarding.png) | ![fsdaf](./readme/demo/Login.png) | ![fsdaf](./readme/demo/Home.png) |

<br><br>

<!-- Database Design -->
<img src="./readme/title5.svg"/>

###  Architecting Data Excellence: Innovative Database Design Strategies:

- Insert ER Diagram here


<br><br>


<!-- Implementation -->
<img src="./readme/title6.svg"/>


### User Screens (Mobile)
| Login screen  | Register screen | Landing screen | Loading screen |
| ---| ---| ---| ---|
| ![Landing](./readme/demo/login_screen.png) | ![fsdaf](./readme/demo/register.png) | ![fsdaf](./readme/demo/home_screen.png) | ![fsdaf](./readme/demo/routes_screen.png) |
| Home screen  | Menu Screen | Order Screen | Checkout Screen |
| ![Landing](./readme/demo/home_screen.png) | ![fsdaf](./readme/demo/welcome.png) | ![fsdaf](./readme/demo/chats.png) | ![fsdaf](https://placehold.co/900x1600) |
<br><br>

<!-- AWS Deployment -->
<img src="./readme/title8.svg"/>

###  Efficient AI Deployment: Unleashing the Potential with AWS Integration:

- This project leverages AWS deployment strategies to seamlessly integrate and deploy natural language processing models. With a focus on scalability, reliability, and performance, we ensure that AI applications powered by these models deliver robust and responsive solutions for diverse use cases.

<br><br>

<!-- Unit Testing -->
<img src="./readme/title9.svg"/>

###  Precision in Development: Harnessing the Power of Unit Testing:

- This project employs rigorous unit testing methodologies to ensure the reliability and accuracy of code components. By systematically evaluating individual units of the software, we guarantee a robust foundation, identifying and addressing potential issues early in the development process.

<br><br>


<!-- How to run -->
<img src="./readme/title10.svg"/>

> To set up Bike Track locally, follow these steps:

### Prerequisites

First install npm and Nest CLI globally
* npm
  ```sh
  npm install npm@latest -g
  npm install -g @nestjs/cli
  ```

### Installation

1. Get a Google Map API Key at [google cloud console](https://console.cloud.google.com/)

2. Clone the repo
   git clone [github](https://github.com/kamilawad/Bike-Track)
   
3. Enter your API in `config.js`
   ```js
   const GOOGLE_MAP_API_KEY = 'ENTER YOUR API';
   ```
4. Install NPM packages
   ```sh
   cd server
   npm install
   ```
5. Run NestJs server
```sh
   npm run start:dev
   ```

Now, you should be able to run Bike Track locally and explore its features.