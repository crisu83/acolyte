'use strict';

angular.module('acolyte')
  .factory('apiService', function ($http) {

    function getTwitchAuthUrl() {
      return $http.post('/api/twitch/authUrl');
    }

    function getTwitchToken(code) {
      return $http.post('/api/twitch/token', {code: code});
    }

    return {
      getTwitchAuthUrl: getTwitchAuthUrl,
      getTwitchToken: getTwitchToken
    };

  });
