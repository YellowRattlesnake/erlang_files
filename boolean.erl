-module(boolean).
-export([b_not/1, b_and/2, b_or/2, b_nand/2]).

b_not(false)->
    true;
b_not(true) ->
    false.

b_and(false, true)->
    false;
b_and(true, false) ->
    false;
b_and(true, true) ->
    true;
b_and(false, false) ->
    false.

b_or(true, true)->
    true;
b_or(true, false) ->
    true;
b_or(false, true) ->
    true;
b_or(false, false) ->
    false.

b_nand(X, Y)->
    b_and(b_not(X),b_not(Y)).







    

