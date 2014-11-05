
angular.module('kbc.applications')
  .service 'KbApplications', () ->
    [
      id: 'tagging'
      name: 'Tagging'
      description: 'Describe your data with predefined or custom tags'
      ui: 'kbc.docToolTagging'
    ,
      id: 'recipes'
      name: 'Recipes'
      description: 'Create predefined transformations or run analysis on your data'
      ui: 'kbc.docToolRecipes'
    ]
