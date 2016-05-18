-module(utility).
-include ("../include/macro.hrl").
-export([private_msg/2,show/1]).

private_msg(Msg,[{_Key,Node}])->
    {node,Node}!{private,?Cut(node()),Msg}.

show({_Key,[]}) ->
    [];
show({Key,_Value})->
    io:format("~p.~n",[Key]),
    show({ets:next(users,Key),ets:lookup(users,ets:next(users,Key))}).
