'use strict';

angular.module('acolyte', [
  'ngRoute',
  'ngAnimate',
  'ui.bootstrap',
  'toggle-switch',
  'LocalStorageModule'
])
  .value('config', {
    authScope: 'user_read channel_editor channel_commercial channel_subscriptions'
  })
  .config(function (localStorageServiceProvider) {
    localStorageServiceProvider.setPrefix('acolyte');
  })
  .config(function ($routeProvider) {
    function ensureAuthenticated($q, authService) {
      var state = authService.getState();
      if (authService.isAuthenticated(state)) {
        return $q.when(state.user);
      } else {
        return $q.reject({auth: false});
      }
    }

    $routeProvider.when('/', {
      templateUrl: 'partials/index.html',
      controller: 'IndexCtrl'
    });

    $routeProvider.when('/commands', {
      templateUrl: 'partials/commands.html',
      controller: 'CommandsCtrl'
    });

    $routeProvider.when('/memory', {
      templateUrl: 'partials/memory.html',
      controller: 'MemoryCtrl'
    });

    $routeProvider.when('/login', {
      templateUrl: 'partials/loading.html',
      controller: 'LoginCtrl'
    });

    $routeProvider.when('/auth', {
      templateUrl: 'partials/loading.html',
      controller: 'AuthCtrl'
    });

    $routeProvider.when('/logout', {
      templateUrl: 'partials/loading.html',
      controller: 'LogoutCtrl'
    });

    $routeProvider.when('/community', {
      templateUrl: 'partials/community.html',
      controller: 'CommunityCtrl',
      resolve: {
        auth: ensureAuthenticated
      }
    });

    $routeProvider.when('/settings', {
      templateUrl: 'partials/settings.html',
      controller: 'SettingsCtrl',
      resolve: {
        auth: ensureAuthenticated
      }
    });

    $routeProvider.otherwise({redirectTo: '/'});
  })
  .run(function ($rootScope, $location, authService) {
    var state = authService.getState();
    $rootScope.user = state && state.user ? state.user : null;

    $rootScope.$on('#routeChangeError', function (name, current, previous, event) {
      if (event.auth === false) {
        $location.path('/login');
      }
    });
  });
