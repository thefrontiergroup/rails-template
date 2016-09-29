easySignIn = ->

  $signIn = $(".easy-sign-in")
  if $signIn
    $form     = $("form")
    $email    = $("#user_email")
    $password = $("#user_password")

    $("a").filter("[data-email]").click (event) ->
      event.preventDefault()
      $el = $(this)
      $email.val $el.data('email')
      $password.val $el.data('password')
      $form.submit()

$(document).ready(easySignIn)
