///single_cellular(seed, method, x, y)

var seed = argument0;
var method = argument1;
var xx = argument2;
var yy = argument3;
var xr = round(argument2);
var yr = round(argument3);
var CellularJitterModifier = 0.6 //argument3;

enum CellularDistanceFunction{
Euclidean,
EuclideanSq,
Manhattan,
Hybrid
}

var distance_function = CellularDistanceFunction.Hybrid;

enum CellularReturnType{
CellValue,
Distance,
Distance2,
Distance2Add,
Distance2Sub,
Distance2Mul,
Distance2Div
}

if (method = 1) {var return_type = CellularReturnType.CellValue}
if (method = 2) {var return_type = CellularReturnType.Distance2Sub}

var MaxValue = 999999999999999;
var PrimeX = 501125321;
var PrimeY = 1136930381;


var distance0 = MaxValue;
var distance1 = MaxValue;
var closestHash = 0;

var cellularJitter = 0.43701595 * CellularJitterModifier;

var xPrimed = (xr - 1) * PrimeX;
var yPrimedBase = (yr - 1) * PrimeY;






switch (distance_function)
{
  default:
  case CellularDistanceFunction.Euclidean:
  case CellularDistanceFunction.EuclideanSq:
  
    for (var xi = xr - 1; xi <= xr + 1; xi++){
      var yPrimed = yPrimedBase;
      
      for (var yi = yr - 1; yi <= yr + 1; yi++){
        var hash = gold_noise(seed, xPrimed, yPrimed);
        //var idx = hash & (255 << 1);
        
        var vecX = (xi - xx) + hash * cellularJitter;
        var vecY = (yi - yy) + hash * cellularJitter;
        
        var newDistance = vecX * vecX + vecY * vecY;
        
        distance1 = max(min(distance1, newDistance), distance0);
        if (newDistance < distance0){
          distance0 = newDistance;
          closestHash = hash;
        }
        
        yPrimed += PrimeY;
      }
      xPrimed += PrimeX;
    }
  break;




case CellularDistanceFunction.Manhattan:
for (var xi = xr - 1; xi <= xr + 1; xi++)
{
    var yPrimed = yPrimedBase;

for (var yi = yr - 1; yi <= yr + 1; yi++)
{
    var hash = gold_noise(seed, xPrimed, yPrimed);
    
    var vecX = (xi - xx) + hash * cellularJitter;
    var vecY = (yi - yy) + hash * cellularJitter;
    
    var newDistance = abs(vecX) + abs(vecY);
    
    distance1 = max(min(distance1, newDistance), distance0);
if (newDistance < distance0)
{
      distance0 = newDistance;
      closestHash = hash;
}
    yPrimed += PrimeY;
}
   xPrimed += PrimeX;
}
break;
case CellularDistanceFunction.Hybrid:
for (var xi = xr - 1; xi <= xr + 1; xi++)
{
    var yPrimed = yPrimedBase;
    
for (var yi = yr - 1; yi <= yr + 1; yi++)
{
      var hash = gold_noise(seed, xPrimed, yPrimed);
      
      var vecX = (xi - xx) + hash * cellularJitter;
      var vecY = (yi - yy) + hash * cellularJitter;
      
      var newDistance = (abs(vecX) + abs(vecY)) + (vecX * vecX + vecY * vecY);
      
      distance1 = max(min(distance1, newDistance), distance0);
if (newDistance < distance0)
{
        distance0 = newDistance;
        closestHash = hash;
}
      yPrimed += PrimeY;
}
    xPrimed += PrimeX;
}
break;
}

if (distance_function == CellularDistanceFunction.Euclidean && return_type >= CellularReturnType.Distance)
{
  distance0 = sqrt(distance0);
  
if (return_type >= CellularReturnType.Distance2)
{
  distance1 = sqrt(distance1);
}
}

switch (return_type)
{
case CellularReturnType.CellValue:
return closestHash // *(1/ 21474836480);
case CellularReturnType.Distance:
return distance0 - 1;
case CellularReturnType.Distance2:
return distance1 - 1;
case CellularReturnType.Distance2Add:
return (distance1 + distance0) * 0.5 - 1;
case CellularReturnType.Distance2Sub:
return distance1 - distance0 - 1;
case CellularReturnType.Distance2Mul:
return distance1 * distance0 * 0.5 - 1;
case CellularReturnType.Distance2Div:
return distance0 / distance1 - 1;
default:
return 0;
}

