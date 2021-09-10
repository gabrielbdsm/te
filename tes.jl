using Genie, Genie.Router, Genie.Renderer.Html, Genie.Requests
using Merly


@page "/" HTTP.Response(200,"Hello World!")

start(host = "127.0.0.1", port = 8086, verbose = true)