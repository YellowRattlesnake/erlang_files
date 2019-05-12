-module(numberSort).
-export([sort/1, print/0]).


%% this is to sort the numbers in erlang 
sort(L)-> 
    lists:sort(L).

print()->
    Value = 32,
    io:format("THis is a second printed statement: ~p~n",[Value]),
    io:format("This is a printed statement, count: ~p~n",[Value]).
    
