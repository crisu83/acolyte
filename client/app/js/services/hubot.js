'use strict';

angular.module('acolyte')
  .factory('hubotService', function ($http) {

    function auth() {
      return $http.post('/api/twitch/init');
    }

    return {
      auth: auth
    };

  });
