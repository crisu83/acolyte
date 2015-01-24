'use strict';

angular.module('acolyte')
  .factory('apiService', function ($http) {

    function dumpMemory() {
      return $http.get('/api/memory');
    }

    function deleteMemoryEntry(id) {
      return $http.delete('/api/memory', {
        params: {
          id: id
        }
      });
    }

    function getTwitchAuthUrl() {
      return $http.post('/api/twitch/authUrl');
    }

    function getTwitchToken(code) {
      return $http.post('/api/twitch/token', {
        code: code
      });
    }

    function getUserSettings(username) {
      return $http.get('/api/settings', {
        params: {
          username: username
        }
      });
    }

    function setUserSettings(username, settings) {
      return $http.post('/api/settings', {
        username: username,
        settings: settings
      });
    }

    return {
      dumpMemory: dumpMemory,
      deleteMemoryEntry: deleteMemoryEntry,
      getTwitchAuthUrl: getTwitchAuthUrl,
      getTwitchToken: getTwitchToken,
      getUserSettings: getUserSettings,
      setUserSettings: setUserSettings
    };

  });
