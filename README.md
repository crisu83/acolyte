Acolyte
=======

Acolyte is your personal Twitch robot.
He is built on top of [Hubot](https://github.com/github/hubot),
GitHub's customizable life embetterment robot.

## Getting started

To install Acolyte on your own server there is a few things you need to do:

- Download the zipball or clone the project
- Open the project folder and run ```npm install``` to install the dependencies
- Set the following environmental variables ```HUBOT_IRC_NICK```, ```HUBOT_IRC_PASSWORD``` and ```HUBOT_IRC_ROOMS```
- Now you can start Acolyte by running ```npm start```

There is also a great guide on how to deploy Hubot on Heroku free tier [here](https://github.com/github/hubot/blob/master/docs/deploying/heroku.md).

## Scripts

Acolyte comes with a number of custom scripts:

- [acolyte.coffee](scripts/acolyte.coffee) contains all generic logic
- [destiny.coffee](scripts/destiny.coffee) contains destiny specific logic
