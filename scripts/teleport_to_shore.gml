
for (var i = 0; i < global.numberOfLocalPlayers; i++){
  if (i = 0) {
    teleport(25600, 25600, 0)
  }else{
    teleport(25600+random(64), 25600+random(64), i)
  }
}

show_debug_message(global.numberOfLocalPlayers)

