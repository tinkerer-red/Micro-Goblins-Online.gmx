/// debugger_get_player_name


//var array = gui_get_item(guid, "Player Name")

var orig_value = obj_player.name //array[0]

var new_name = get_string("Player Name", orig_value);

//set all the local player names to the debug's name string
with (obj_player){
  if htme_isLocal(){
    self.name = new_name
    
    switch (string_lower(self.name))
    {
    case "red":
      head = spr_head_dev_skin_head_red;
      body = spr_head_dev_skin_body_red;
      break;
    case "arma":
    case "armadillo":
      head = spr_head_template;
      body = spr_body_template;
      break;
    case "olaf":
      head = spr_head_dev_skin_head_olaf;
      body = spr_head_dev_skin_body_olaf;
      break;
    case "shiv":
    case "shaymire":
      head = spr_head_dev_skin_head_shaymire;
      body = spr_head_dev_skin_body_shaymire;
      break;
    case "nostud thiago":
      head = spr_head_dev_skin_head_nostud_thiago;
      body = spr_head_dev_skin_body_nostud_thiago;
      break;
    default:
      head = spr_head_template;
      body = spr_body_template;
    }
  }
}

