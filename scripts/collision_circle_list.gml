/// collision_circle_list(x1, y1, radius, obj, prec, notme)


var x1, y1, radius, obj, prec, notme;

var x1 = argument[0]
var y1 = argument[1]
var radius = argument[2]
var obj = argument[3]
var prec = argument[4]  // -1 = just guess based off x,y distance
var notme = argument[5]

var dsid = ds_list_create()

with (obj) {
  if (!notme || id != other.id){
    if (prec = -1){
      if (point_distance(x1, y1, x, y) < radius){
        var i = id
      }else{
        var i = noone
      }
    }else{
      var i = collision_circle(x1, y1, radius, id, prec, false)
    }
    if (i != noone) ds_list_add(dsid, i);
  }
}
if (ds_list_empty(dsid)){
  ds_list_destroy(dsid);
  dsid = noone;
}

return dsid;
