///chunk_debug_toggle()

if (obj_chunk_supervisor.show_chunks = false) {
  obj_chunk_supervisor.show_chunks = true
}else{
  obj_chunk_supervisor.show_chunks = false
}

with (obj_chunk) {
  show_chunks = obj_chunk_supervisor.show_chunks
}
