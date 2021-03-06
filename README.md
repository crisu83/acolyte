# Acolyte

Acolyte is your personal Twitch robot.
He is built on top of [Hubot](https://github.com/github/hubot),
GitHub's customizable life embetterment robot.

## Background

When I started streaming my Destiny gameplay I looked at all the free chat bots available for Twitch and I noticed that while [Nightbot](https://www.nightbot.tv) does a great job at monitoring among other things there isn't many for a streamer to choose from.

I wanted to make sure that I don't "re-invent the wheel" so I sat down and thought about different ideas of what the bot could do. I came up with the idea of a robot who you could ask almost anything and even if he wouldn't know the answer he would look it up for you. This is when Acolyte was born.

Acolyte isn't just a robot, he has a personality. He will always be polite and never yell at you. His knowledge still is a bit limited but it is easy to extend by adding more scripts to his brain.

## Getting started

To install Acolyte on your own server there is a few things you need to do:

- Download the zipball or clone the project
- Open the project folder and run ```npm install``` to install the dependencies
- Set the following environmental variables ```HUBOT_TWITCH_USERNAME```, ```HUBOT_TWITCH_PASSWORD``` and ```HUBOT_TWITCH_CHANNELS```
- Now you can start Acolyte by running ```npm start```

There is also a great guide on how to deploy Hubot on Heroku free tier [here](https://github.com/github/hubot/blob/master/docs/deploying/heroku.md).

## Scripts

Acolyte comes with a number of custom scripts:

- [acolyte.coffee](scripts/acolyte.coffee) contains all generic logic
- [destiny.coffee](scripts/destiny.coffee) contains Destiny specific logic
- [twitch.coffee](scripts/twitch.coffee) contains Twitch specific logic
