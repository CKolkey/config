if Debugger then
  return
end

Debugger = {
  messages = {}
}

function Debugger.log(...)
  table.insert(Debugger.messages, { ... })
end
