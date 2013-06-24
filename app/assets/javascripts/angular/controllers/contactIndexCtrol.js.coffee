@ContactIndexCtrl = ($scope, $resource) ->
#  Contact = $resource("/contacts/:id", {id: "@id"}, {update: {method: "PUT"}})
#  $scope.contacts = Contact.query()
#
#  $scope.deleteContact = (c) ->
#    c.$delete()
#    $scope.contacts.splice($scope.contacts.indexOf(c),1)
#
#  $scope.updateContact = (c) ->
#    c.$update()
#
#  $scope.createContact = ->
#    c = Contact.save({name: "New Contact", email: "email@example.com",
#      ezine: true, notification: true, group: "WEB"})
#    $scope.contacts.push(c)


