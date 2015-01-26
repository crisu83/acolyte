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
        localStorageService.set('user', data.user);
        localStorageService.set('token', data.token);
        dfd.resolve(data.user);
      })
      .error(function (error) {
        dfd.reject(error);
      });
    return dfd.promise;
  }

  function logout() {
    localStorageService.remove('user');
    localStorageService.remove('token');
  }

  function getUser() {
    return localStorageService.get('user');
  }

  function getToken() {
    return localStorageService.get('token');
  }

  function isGuest() {
    return getUser() === null || getToken() === null;
  }

  return {
    getAuthUrl: getAuthUrl,
    login: login,
    logout: logout,
    getUser: getUser,
    getToken: getToken,
    isGuest: isGuest
  };

});
