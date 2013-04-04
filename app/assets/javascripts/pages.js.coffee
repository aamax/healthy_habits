# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('.nav li').children().click ->
    $('.nav li').removeClass "active"
    $(this).parent().addClass "active"

  $('.nav li').removeClass "active"
  pg = $("#page_name").val()
  if pg == undefined
    $("#home_menu").parent().addClass "active"
  else
    $("#" + pg + "_menu").parent().addClass "active"

