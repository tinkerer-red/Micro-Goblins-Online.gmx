var arg = argument0
show_debug_message("Thread: "+string(arg))
for (var i = 0; i < 10000; i++){
  if (i % 1000 = 0){
    show_debug_message("Thread: "+string(arg))
  }
  
}
