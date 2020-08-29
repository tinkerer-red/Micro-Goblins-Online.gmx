///scr_mod_enlarge
//
//global
//weapon spawn modifier

if (self.weap_inst.image_xscale > 1)
{
  self.weap_inst.image_xscale -= 1 //self.weap_inst.image_xscale*1.5
  self.weap_inst.image_yscale -= 1 //self.weap_inst.image_yscale*1.5
}else{
  self.weap_inst.image_xscale -= 0.1 //self.weap_inst.image_xscale*1.5
  self.weap_inst.image_yscale -= 0.1 //self.weap_inst.image_yscale*1.5
}

return true

