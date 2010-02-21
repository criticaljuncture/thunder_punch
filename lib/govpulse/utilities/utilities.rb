# This method is to help format messages to the user in a more recognizable way
def alert_user(message, options={})
  abort = options.delete(:abort) || false
  wrapped_message = <<-EOF
  \n\n
  *******************************************************************\n

    #{message} \n

  *******************************************************************
  \n\n
  EOF

  if abort
    abort(wrapped_message)
  else
    puts wrapped_message
  end
end