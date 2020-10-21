///section_percent(percent, sections)

// percent 0-1
// sections the number of sections to make use of starting with 1

var percent = argument0
var sections = argument1

var sect_perc = 1/sections

var sect = sect_perc

while (percent >= sect){
  sect += sect_perc
}

clamp(sect, 0, 1)

return sect;
