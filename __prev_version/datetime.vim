:function GetDate()
:  return strftime('%Y_%m_%d')
:endfunction

:function GetDateTime()
:  return strftime('%Y_%m_%d_%H%M%S')
:endfunction

:command PutDate :put =GetDate()
:command PutDateTime :put =GetDateTime()
:command ClipDate :let @@ =GetDate()
:command ClipDateTime :let @@ =GetDateTime()

