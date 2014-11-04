
angular.module('kbc.applications')
  .service 'KbReactPageHeader', () ->

    {table, tr, td, th, thead, tbody, span, div, a, p, h4} = React.DOM

    React.createClass(
      displayName: 'PageHeader'
      render: ->
        (div className: 'page-header',
          (div className: 'container',
            (div className: 'row',
              (div className: 'col-md-9',
                (h4 {}, 'Applications')
              )
            )
          )
        )
    )
