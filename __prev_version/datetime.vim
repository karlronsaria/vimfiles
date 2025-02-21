:function GetDate()
:  return strftime('%Y-%m-%d')
:endfunction

:function GetDateTime()
:  return strftime('%Y-%m-%d-%H%M%S')
:endfunction

:command PutDate :put =GetDate()
:command PutDateTime :put =GetDateTime()
:command ClipDate :let @@ =GetDate()
:command ClipDateTime :let @@ =GetDateTime()

