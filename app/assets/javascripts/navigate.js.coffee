$(document).ready ->
  # highlight the correct menu option
  str = this.documentURI
  idx = str.indexOf("/pages/") + 7
  if idx != 6
    tag = str.slice(idx)
    $("#" + tag).addClass('active')
    alert('highlighting ' + tag)

