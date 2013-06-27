angular.module "HHabits", ["ngResource", "ng-rails-csrf"]

@ContactCtrl = ($scope, $resource) ->
  Contact = $resource("/contacts/:id", {id: "@id"}, {update: {method: "PUT"}})
  $scope.contacts = Contact.query()
  $scope.fname = 'a'
  $scope.lname = 'a'
  $scope.email = 'aamax@xmission.com'
  $scope.ezine_list = true
  $scope.microscopy_list = true
  $scope.cleanse_list = true
  $scope.coaching_list = true
  $scope.events_list = true
  $scope.products_list = true

  $scope.enterContact = () ->
    if (($scope.fname == '') || ($scope.lname == '') || ($scope.email == '') || ($scope.fname == undefined) || ($scope.lname == undefined) || ($scope.email == undefined))
      alert('Contact Information Fields are all required and email must be valid.')
      return

    if (($scope.report_list == false) && ($scope.microscopy_list == false) && ($scope.cleanse_list == false) && ($scope.coaching_list == false) && ($scope.events_list == false) && ($scope.products_list == false))
      alert('At least one list must be selected.')
      return

    obj = {fname: $scope.fname, lname: $scope.lname, email: $scope.email, ezine_list: $scope.ezine_list, microscopy_list: $scope.microscopy_list, cleanse_list: $scope.cleanse_list, coaching_list: $scope.coaching_list, products_list: $scope.products_list, events_list: $scope.events_list }
    contact = new Contact(obj)
    angular.element('#contactsModal').modal('hide')

    contact.$save(->
      angular.element('#contactsModal').modal('hide')
      alert('Contact Saved.')
    , (data) ->
      err = 'error saving: ' + data.status
      if data.data.errors.email
        err += '\nemail address: ' + data.data.errors.email[0]
      if data.data.errors.fname
        err += '\nfname: ' + data.data.errors.fname[0]
      if data.data.errors.lname
        err += '\nlname: ' + data.data.errors.lname[0]
      alert(err)
      angular.element('#contactsModal').modal('hide')
    )












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
