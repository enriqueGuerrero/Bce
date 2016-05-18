%Description:developed by Enrique Iván Guerrero Martínez <enrique.eigm@gmail.com>

-module(main).
-include ("../include/macro.hrl").
-export([connect/1,pid/0,public/1]).

connect(Name)->
   pong=net_adm:ping(Name).

pid()->
    Pid=spawn(fun()->loop()end),
    register(node,Pid),
    node!init.

public(Msg)->
    [Name|_Host]=?Cut(node()),
    [{node,Node}!{public,Msg,Name}||Node<-nodes()].

loop()->
    receive           
        show-> 
            utility:show({ets:first(users),ets:lookup(users,ets:first(users))}),
            loop();
        init->
            ok=net_kernel:monitor_nodes(true),
            ets:new(users,[ordered_set,public,named_table]),
            loop();
        {nodedown,Node}->
            [Name|_Host]=?Cut(Node),
            io:format("~p has been disconnected. ~n",[list_to_atom(Name)]),
            true=ets:delete(users,list_to_atom(Name)),
            loop();
        {nodeup,Node}->
            [Name|_Host]=?Cut(Node),
            io:format("~p has been connected.~n",[list_to_atom(Name)]),
            true=ets:insert(users,{list_to_atom(Name),Node}),
            loop();
        {public,Msg,From}->
            io:format ("~p says: ~p.~n",[list_to_atom(From),Msg]),
            loop();
        {private,[Name,_Host],Msg}->
            io:format ("~p says: ~p.~n",[list_to_atom(Name),Msg]),
            loop();
        {Key,Msg}->
            utility:private_msg(Msg,ets:lookup(users,Key)),
            loop();
        _Unknown->
             io:format ("Received msg unknown: ~p~n",[unknow]),
             loop()
    end.
