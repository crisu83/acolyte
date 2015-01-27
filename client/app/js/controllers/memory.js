'use strict';

angular.module('acolyte')
  .controller('MemoryCtrl', function ($scope, $interval, apiService, loaderService) {

    $scope.memory = {};

    function loadMemory() {
      loaderService.load('loadMemory');
      apiService.dumpMemory()
        .success(function (json) {
          loaderService.done('loadMemory');
          if (json.success) {
            $scope.memory = json.data.memory;
          }
        })
        .error(function (data) {
          loaderService.done('loadMemory');
        });
    }

    function deleteItem(id) {
      loaderService.load('deleteItem');
      apiService.deleteMemoryEntry(id)
        .success(function (json) {
          loaderService.done('deleteItem');
          if (json.success) {
            delete $scope.memory[id]
          }
        })
        .error(function (json) {
          loaderService.done('deleteItem');
        });
    }

    loadMemory();

    $interval(loadMemory, 1000 * 30);

    $scope.deleteItem = deleteItem;

  });
