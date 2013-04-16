# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
angular.module "HHabits", ["ngResource", "ng-rails-csrf"]


@ContactCtrl = ($scope, $resource) ->
  Contact = $resource("/contacts/:id", {id: "@id"}, {update: {method: "PUT"}})
  $scope.contacts = Contact.query()

  $scope.deleteContact = (c) ->
    c.$delete()
    $scope.contacts.splice($scope.contacts.indexOf(c),1)

  $scope.updateContact = (c) ->
    c.$update()

  $scope.createContact = ->
    c = Contact.save({name: "New Contact", email: "email@example.com", \
                                  ezine: true, notification: true, group: "WEB"})
    $scope.contacts.push(c)

