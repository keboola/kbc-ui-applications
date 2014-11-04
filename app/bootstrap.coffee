###
  Mockup bootstrap
###

jQuery(($) ->
  appName = 'kbc.applications'
  sapiUrl = 'https://connection.keboola.com'

  getParameterByName = (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
    results = regex.exec(location.search)
    (if not results? then "" else decodeURIComponent(results[1].replace(/\+/g, " ")))

  startApp = (configuration, verifiedTokenData) ->
    # create configuration
    angular.module(appName)
    .constant("#{appName}.config",
        sapi:
          token: verifiedTokenData
          endpoint: sapiUrl
        basePath: '/'
        appName: appName
        components: configuration.components
        writerId: getParameterByName('writerId')
        projectBaseUrl: "#{sapiUrl}/projects-new/#{verifiedTokenData.owner.id}"
      )

    angular.bootstrap(angular.element.find('body'), [appName])

  $.when(
    $.get("#{sapiUrl}/v2/storage")
    $.ajax("#{sapiUrl}/v2/storage/tokens/verify",
      headers:
        'X-StorageApi-Token': getParameterByName 'token'
    )
  ).done((stackInfoResponse, verifyResponse) ->
    startApp(stackInfoResponse[0], verifyResponse[0])
  )
)



