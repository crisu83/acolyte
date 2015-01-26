'use strict';

angular.module('acolyte')
  .factory('apiService', function ($http) {

    function getStatus(channel, token) {
      return $http.get('/api/status', {
        params: {
          channel: channel,
          token: token
        }
      });
    }

    function joinChannel(channel, token) {
      return $http.post('/api/join', {
        channel: channel,
        token: token
      });
    }

    function partChannel(channel, token) {
      return $http.post('/api/part', {
        channel: channel,
        token: token
      });
    }

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

    function getChannelSettings(channel, token) {
      return $http.get('/api/settings', {
        params: {
          channel: channel,
          token: token
        }
      });
    }

    function setChannelSettings(channel, token, settings) {
      return $http.post('/api/settings', {
        channel: channel,
        token: token,
        settings: settings
      });
    }

    return {
      getStatus: getStatus,
      joinChannel: joinChannel,
      partChannel: partChannel,
      dumpMemory: dumpMemory,
      deleteMemoryEntry: deleteMemoryEntry,
      getTwitchAuthUrl: getTwitchAuthUrl,
      getTwitchToken: getTwitchToken,
      getChannelSettings: getChannelSettings,
      setChannelSettings: setChannelSettings
    };

  });
