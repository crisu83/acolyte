'use strict';

angular.module('acolyte')
.factory('authService', function ($q, config, apiService, localStorageService) {

  var STORAGE_KEY = 'acolyte.state';

  function getAuthUrl() {
    var dfd = $q.defer();
    apiService.getAuthUrl()
      .success(function (json) {
        if (json.success) {
          var authUrl = json.data.url + '&scope=' + config.authScope;
          dfd.resolve(authUrl);
        }
      })
      .error(function (json) {
        dfd.reject(json.error);
      });
    return dfd.promise;
  }

  function login(code) {
    var dfd = $q.defer();
    apiService.postAuthCode(code)
      .success(function (json) {
        if (json.success) {
          localStorageService.set(STORAGE_KEY, json.data);
          dfd.resolve(json.data.user);
        }
      })
      .error(function (json) {
        dfd.reject(json.error);
      });
    return dfd.promise;
  }

  function logout() {
    localStorageService.remove(STORAGE_KEY);
  }

  function getState() {
    return localStorageService.get(STORAGE_KEY);
  }

  function isAuthenticated(state) {
    return state && state.user && state.token;
  }

  return {
    getAuthUrl: getAuthUrl,
    login: login,
    logout: logout,
    getState: getState,
    isAuthenticated: isAuthenticated
  };

});
