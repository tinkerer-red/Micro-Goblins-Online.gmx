/// sgs_LineTouchesRect(lx1, ly1, lx2, ly2, left,top,rigth,bottom)
    {
        var lx1 = argument0;
        var ly1 = argument1;
        var lx2 = argument2;
        var ly2 = argument3;
        var left = argument4;
        var top = argument5;
        var right = argument6;
        var bottom = argument7;
        return sgs_LineIntersectsLine(lx1,ly1,lx2,ly2,left,top,right,top) ||
               sgs_LineIntersectsLine(lx1,ly1,lx2,ly2,left,top,left,bottom) ||
               sgs_LineIntersectsLine(lx1,ly1,lx2,ly2,right,bottom,right,top) ||
               sgs_LineIntersectsLine(lx1,ly1,lx2,ly2,right,bottom,left,bottom) ||
               (sgs_PointInRect(lx1,ly1,left,top,right,bottom) && sgs_PointInRect(lx2,ly2,left,top,right,bottom));
    }
