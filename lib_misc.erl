-module(lib_misc).
-export([on_exit/1]).

on_exit(Pid)->
    spawn(fun() ->
		  Ref = monitor(process,Pid),
		  Start_Time = os:system_time(second),
		  receive
		      {'DOWN', Ref, process, Pid, Why} ->
			  io:format("Process managed to run for ~p seconds, died for reason: ~p~n", [os:system_time(second)-Start_Time, Why])
		  end
	  end).

%%keep_alive(Name, Fun)->
  %%  register(Name, Pid = spawn(Fun)),
   %% on_exit(Pid, fun(_Why)->
%%			 keep_alive(Name, Fun) end).

