-module(ws281x_nif).

-on_load(load_nif/0).

-export([]).

-spec load_nif() -> ok.
load_nif() ->
    SoName = get_priv_path(?MODULE),
    io:format(<<"Loading library: ~p ~n">>, [SoName]),
    ok = erlang:load_nif(SoName, 0).

%% API


%% internals
get_priv_path(File) ->
    case code:priv_dir(ws281x_erl) of
        {error, bad_name} ->
            Ebin = filename:dirname(code:which(?MODULE)),
            filename:join([filename:dirname(Ebin), "priv", File]);
        Dir ->
            filename:join(Dir, File)
    end.
