#!/usr/bin/env coffee

http = require 'http'
url = require 'url'
childp = require 'child_process'

http.createServer (req, res) ->
  res.writeHead 200, {'Content-Type': 'text/plain'}
  url_parts = url.parse req.url, true
  ip = url_parts.query.ip  
  if ip && -1 != ip.search '192.168.2.'
    exec "sed -i \"s/192.168.2.* colnect/#{ip} colnect/g\" /etc/hosts", (rtn) ->
      res.write rtn + '\n'
      printColnect(res)
  else
    printColnect(res)
.listen 1133, '0.0.0.0'
console.log 'Server running at http://127.0.0.1:1133/'

# Print colnect record in /etc/hosts
printColnect = (res) ->
  exec "grep colnect /etc/hosts", (rtn) ->
    res.end rtn

# Execute a command
exec = (cmd, callback) ->
  rtn = '\ncmd:\n----\n' + cmd
  childp.exec cmd, (error, stdout, stderr) ->
    rtn += "\n\nstdout:\n----\n" + stdout if stdout
    rtn += "\n\nstderr:\n----\n" + stderr if stderr
    rtn += "\n\nerror :\n----\n" + error if error
    callback(rtn) if callback

