### configuration defaults
  In dev mode injected by bootstrap.coffee script
  I
  n production deployed into kbc provided by kbc
###
angular
.module('kbc.applications.config', [])
.constant('kbc.applications.config',
  appName: 'kbc.applications'
  appVersion: 'v1'
  templatesBasePath: '/app'
  token: {} # token object
  components: [] # list of kbc components provided by https://connection.keboola.com/v2/storage
)

angular
.module('kbc.applications', [
  # ng modules
  
  'ngSanitize'
  'ngRoute'

  # demo application modules
  'kbc.applications.config'

  # keboola common library
  'kb'
  'kb.accordion'
  'kb.i18n'

  # error handling
  'kb.exceptionHandler'

  # third party library modules
  'ui.bootstrap'
])
.config([
  '$routeProvider'
  '$locationProvider'
  '$tooltipProvider'
  'kbAppVersionProvider'
  'kbc.applications.config'
  ($routeProvider, $locationProvider, $tooltipProvider, appVersionProvider, config) ->
    appVersionProvider
    .setVersion(config.appVersion)
    .setBasePath(config.basePath)

    $tooltipProvider.options(
      appendToBody: true
    )

    $routeProvider
    .when('/',
        templateUrl: "views/pages/index.html"
        controller: 'IndexController'
      )
    .otherwise(
        redirectTo: '/'
      )

    $locationProvider.html5Mode(false)
])

# initialization
.run([
  '$rootScope'
  'kbSapiErrorHandler'
  'kbSapiService'
  'kbAppVersion'
  'kbc.applications.config'
  ($rootScope, storageErrorHandler, storageService, appVersion, appConfig) ->
    getComponentConfig = (id) ->
      component = _.find(appConfig.components, (component) ->
        component.id == id
      )
      throw new Error("Component #{id} not found") if !component
      component

    # wire storage error handler - trigger error modal on error
    $rootScope.$on('storageError', (event, errorResponse) ->
      storageErrorHandler.handleError(errorResponse)
    )

    # set tokens and urls for SAPI and TAPI
    storageService.setVerifiedToken(appConfig.sapi.token)
    storageService.endpoint = appConfig.sapi.endpoint

    # put configs to rootScope to be simple accesible in all views and controllers
    $rootScope.appVersion = appVersion
    $rootScope.appConfig = appConfig

])
.run(['$templateCache', ($templateCache) ->
  $templateCache.put('views/pages/index.html', "<kb-applications></kb-applications>")
])

