
angular.module('kbc.applications')
  .directive 'kbApplications', ['KbReactAppsList', 'KbReactPageHeader', 'KbApplications', (AppsList, PageHeader, applications) ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      PageHeader = React.createFactory(PageHeader)
      AppsList = React.createFactory(AppsList)


      app = React.createFactory(React.createClass(
        render: ->
          (React.DOM.div null,
            PageHeader(),
            AppsList(apps: applications)
          )
      ))

      React.render(app(), element[0])
  ]
