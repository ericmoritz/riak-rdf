-module(riak_rdf).
-compile(export_all).

-record(statement, {s,p,o}).
-record(uri, {uri}).


filter_graph(Graph, Pattern) ->
    flatmap(
      fun(Statement) -> filter_statement(Statement, Pattern) end,
      Graph
    ).
	      
      
flatmap(F, L) ->
    %% Is this efficient? Fuck it! Its a prototype!
    lists:flatten([
     F(X) || X <- L
    ]).


filter_statement(Statement={statement, S, P, O}, {statement, S, P, O}) ->
    [Statement];
filter_statement(Statement={statement, _, P, O}, {statement, undefined, P, O}) ->
    [Statement];
filter_statement(Statement={statement, _, _, O}, {statement, undefined, undefined, O}) ->
    [Statement];
filter_statement(Statement={statement, _, _, _}, {statement, undefined, undefined, undefined}) ->
    [Statement];
filter_statement(Statement={statement, S, _, O}, {statement, S, undefined, O}) ->    
    [Statement];
filter_statement(Statement={statement, S, _, _}, {statement, S, undefined, undefined}) ->    
    [Statement];
filter_statement(Statement={statement, S, P, _}, {statement, S, P, undefined}) ->    			
    [Statement];
filter_statement(Statement={statement, _, P, _}, {statement, undefined, P, undefined}) ->    			
    [Statement];
filter_statement(_, _) ->
    [].


demo_graph() ->
    [
     {statement, {uri, "http://eric.themoritzfamily.com/"}, {uri, "http://schema.org/name"}, "Eric Moritz"},
     {statement, {uri, "http://eric.themoritzfamily.com/"}, {uri, "http://schema.org/homepage"}, {uri, "http://eric.themoritzfamily.com/"}}
    ].
