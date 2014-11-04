
angular.module('kbc.applications')
  .service 'KbApplications', () ->
    [
      id: 'tagging'
      name: 'Tagging'
      description: 'Tagging tool'
      ui: 'kbc.docToolTagging'
    ,
      id: 'recipes'
      name: 'Recipes'
      description: 'Recipes tool'
      ui: 'kbc.docToolRecipes'
    ]
