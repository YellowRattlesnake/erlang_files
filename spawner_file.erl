-module(spawner_file).
-export([my_spawn/3, killable_function/0, my_spawn/4, spawn_still_alive/0, still_alive/0, kill_still_alive/0]).


my_spawn(Mod, Func, Args)->
    spawn(fun()-> 
		  {Pid, Ref} = spawn_monitor(Mod, Func, Args),
		  Init_time = os:system_time(second),
		  io:format("PID is ~p~n", [Pid]),
		  receive
		      {'DOWN', Ref, process,Pid, Why}->
			  io:format("Process ~p ran for time ~p seconds, died for reason:~p~n",[Pid, os:system_time(second)- Init_time, Why])
		  end
	  end).
killable_function()->
    receive
	X -> list_to_atom(X)
    end.

%kill a function after X seconds of time
my_spawn(Mod, Func, Args, Time)->
    spawn(fun()-> 
		  {Pid, Ref} = spawn_monitor(Mod, Func, Args),
		  Init_time = os:system_time(second),
		  register(killable, Pid),
		  receive
		      {'DOWN', Ref, process,Pid, Why}->
			  io:format("Process ~p ran for time ~p seconds, died for reason:~p~n",[Pid, os:system_time(second)- Init_time, Why])
		  after
		      Time ->
			  exit(Pid, "Taking too damn long"),
			  Pid ! hello,
			  io:format("Killed Process~n")
		  end
	  end).

still_alive()->
    io:format("I am still alive! LOL~n",[]),
    timer:sleep(5000), 
    still_alive().

spawn_still_alive()->
    Pid = spawn(spawner_file, still_alive, []),
    register(alive, Pid),
    monitor_alive(Pid).

monitor_alive(Pid)->
    spawn(fun()->
		  Ref = monitor(process,Pid),
		  receive
		      {'DOWN', Ref, process, _Pid, _Why}->
			  spawn_still_alive()
		  end
	  end).

kill_still_alive()->		    
    exit(whereis(alive), kill).
