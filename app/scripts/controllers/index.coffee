
angular.module('kbc.applications')
  .controller('IndexController', [
    "$scope"
    "kbSapiService"
    "kbc.applications.config"
    ($scope, storageService, config) ->

      $scope.appName = config.appName
      $scope.buckets = []
      $scope.bucketsLoading = false

      $scope.refresh = ->
        $scope.bucketsLoading = true
        storageService
          .getBuckets()
          .success( (buckets) ->
            $scope.bucketsLoading = false
            $scope.buckets = buckets
          )
          .error( ->
            $scope.bucketsLoading  = false
          )

      $scope.refresh()
  ])