
angular.module('kbc.applications')
  .service 'KbReactAppsList', ['kbc.applications.config', (config) ->

    {table, tr, td, th, thead, tbody, span, div, a, p, h3} = React.DOM

    App = React.createFactory(React.createClass(
      displayName: 'App'
      propTypes:
        app: React.PropTypes.object.isRequired
      appUrl: ->
        "#{config.projectBaseUrl}/application?app=#{@props.app.ui}"
      goToApp: ->
        window.location.href = @appUrl()
      render: ->
        (div className: 'col-sm-4', onClick: @goToApp,
          (div className: 'panel panel-default kb-component-panel kb-pointer',
            (div className: 'panel-body text-center',
              (h3 null, @props.app.name)
              (p null, @props.app.description)
              (a {href: @appUrl(), className: 'btn btn-primary btn-small'}, 'Go to App')
            )
          )
        )
    ))

    React.createClass
      displayName: 'AppsList'
      propTypes:
        apps: React.PropTypes.array.isRequired

      prepareApps: (apps) ->
        _.chain(apps)
        .sortBy('id')
        .groupBy (index) ->
          Math.floor(index++ / 3)
        .toArray()
        .value()

      renderAppsRow: (apps) ->
        appElements = _.map(apps, (app) ->
          App(app: app)
        , @)

        (div className: 'row', appElements)


      render: ->
        appRows = _.map(@prepareApps(@props.apps), (appsInRow) ->
          @renderAppsRow(appsInRow)
        , @)

        (div className: 'container kbc-applications',
          (div className: 'row',
            (div className: 'col-md-12',
              appRows
            )
          )
        )

  ]