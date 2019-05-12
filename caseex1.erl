-module(caseex1).
-export([caseex1/2]).

caseex1(Item,List)->
    case lists:member(Item, List) of
	true->
	    ok;
	false ->
	    {error, unknown}
    end.
