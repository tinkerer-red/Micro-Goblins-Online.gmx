/// sgs_LineIntersectsLine(l1x1, l1y1, l1x2, l1y2, l2x1, l2y1, l2x2, l2y2)
    {
        var l1x1 = argument0;
        var l1y1 = argument1;
        var l1x2 = argument2;
        var l1y2 = argument3;
        var l2x1 = argument4;
        var l2y1 = argument5;
        var l2x2 = argument6;
        var l2y2 = argument7;
        var q = (l1y1 - l2y1) * (l2x2 - l2x1) - (l1x1 - l2x1) * (l2y2 - l2y1);
        var d = (l1x2 - l1x1) * (l2y2 - l2y1) - (l1y2 - l1y1) * (l2x2 - l2x1);

        if( d == 0 )
        {
            return false;
        }

        var r = q / d;

        q = (l1y1 - l2y1) * (l1x2 - l1x1) - (l1x1 - l2x1) * (l1y2 - l1y1);
        var s = q / d;

        if( r < 0 || r > 1 || s < 0 || s > 1 )
        {
            return false;
        }

        return true;
    }
