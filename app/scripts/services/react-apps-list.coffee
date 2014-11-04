
angular.module('kbc.applications')
  .service 'KbReactAppsList', ['kbc.applications.config', (config) ->

    {table, tr, td, th, thead, tbody, span, div, a, p, h3} = React.DOM

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
          @renderApp(app)
        , @)

        (div className: 'row', appElements)

      renderApp: (app) ->
        (div className: 'col-sm-4',
          (div className: 'panel panel-default kb-component-panel kb-pointer',
            (div className: 'panel-body text-center',
              (h3 null, app.name)
              (p null, app.description)
              (a {href: @appUrl(app), className: 'btn btn-primary btn-small'}, 'Go to App')
            )
          )
        )

      appUrl: (app) ->
        "#{config.projectBaseUrl}/application?app=#{app.ui}"

      render: ->
        appRows = _.map(@prepareApps(@props.apps), (appsInRow) ->
          @renderAppsRow(appsInRow)
        , @)

        (div className: 'container',
          (div className: 'row',
            (div className: 'col-md-12',
              appRows
            )
          )
        )

  ]