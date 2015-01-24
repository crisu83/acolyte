'use strict';

angular.module('acolyte')
.factory('authService', function ($q, config, apiService, localStorageService) {

  function getAuthUrl() {
    var dfd = $q.defer();
    apiService.getTwitchAuthUrl()
      .success(function (data) {
        var authUrl = data.url + '&scope=' + config.authScope;
        dfd.resolve(authUrl);
      })
      .error(function (error) {
        dfd.reject(error);
      });
    return dfd.promise;
  }

  function login(code) {
    var dfd = $q.defer();
    apiService.getTwitchToken(code)
      .success(function (data) {
        var user = data.user;
        localStorageService.set('user', user);
        dfd.resolve(user);
      })
      .error(function (error) {
        dfd.reject(error);
      });
    return dfd.promise;
  }

  function logout() {
    localStorageService.remove('user');
  }

  function getUser() {
    return localStorageService.get('user');
  }

  function isGuest() {
    return getUser() === null;
  }

  return {
    getAuthUrl: getAuthUrl,
    login: login,
    logout: logout,
    getUser: getUser,
    isGuest: isGuest
  };

});
