'use strict';

angular.module('acolyte')
  .controller('CommandsCtrl', function ($scope) {

    $scope.commands = [
      {
        command: '!tell <sentence>',
        description: 'Teaches Acolyte a sentence',
        users: '@'
      },
      {
        command: '!ask <question>',
        description: 'Asks Acolyte a question',
        users: '*'
      },
      {
        command: '!time [timezone]',
        description: 'Tells you the current time',
        users: '*'
      },
      {
        command: '!xur',
        description: 'Tells you all about Xûr',
        users: '*',
        game: 'Destiny'
      },
      {
        command: '!ddb <keyword>',
        description: 'Searches DestinyDB with the keyword',
        users: '*',
        game: 'Destiny'
      },
      {
        command: '!dwiki <keyword>',
        description: 'Searches Destinypedia with the keyword',
        users: '*'
      },
      {
        command: '!psn',
        description: 'Tells you the status of PSN',
        users: '*'
      },
      {
        command: '!about',
        description: 'Tells you some information about Acolyte',
        users: '*'
      }
    ];

  });
