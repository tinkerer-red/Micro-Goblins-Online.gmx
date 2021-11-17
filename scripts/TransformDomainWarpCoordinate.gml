///TransformDomainWarpCoordinate(DomainWarpType, x, y)
var returned_array; 
returned_array[0] = argument1
returned_array[1] = argument2

switch (argument0)
{
    case DomainWarpType.OpenSimplex2:
    case DomainWarpType.OpenSimplex2Reduced:
    {
        //var SQRT3 = 1.7320508075688772935274463415059;
        //var F2 = 0.5f * (SQRT3 - 1);
        var F2 = 0.36602540378443864676372317075295
        
        t = (returned_array[0] + returned_array[1]) * F2;
        returned_array[0] += t;
        returned_array[1] += t;
        
    }
    break;
    default:
        break;
}

return returned_array;

