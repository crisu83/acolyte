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

    function getAuthUrl() {
      return $http.get('/api/twitch/authUrl');
    }

    function postAuthCode(code) {
      return $http.post('/api/twitch/code', {
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

    function getFollows(channel, token) {
      return $http.get('/api/twitch/follows', {
        params: {
          channel: channel,
          token: token
        }
      });
    }

    function getSubscriptions(channel, token) {
      return $http.get('/api/twitch/subscriptions', {
        params: {
          channel: channel,
          token: token
        }
      });
    }

    return {
      getStatus: getStatus,
      joinChannel: joinChannel,
      partChannel: partChannel,
      dumpMemory: dumpMemory,
      deleteMemoryEntry: deleteMemoryEntry,
      getAuthUrl: getAuthUrl,
      postAuthCode: postAuthCode,
      getChannelSettings: getChannelSettings,
      setChannelSettings: setChannelSettings,
      getFollows: getFollows,
      getSubscriptions: getSubscriptions
    };

  });
