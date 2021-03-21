/// lag();
//
//  this function is simply the most optimal way to calculate lag
//  since computers multiply with fewer cpu instructions than they can divide
//
//  Returns: real
//
//  The returned is a multiplier value for lost frames,
//    this function is really only to serve as a
//    replacement for dividing by delta_time by ideal_delta.
//
//  The function also helps clean up the code a bit in my opinion
//
/// GMLscripts.com/license


//returning this multiple allows for simple equasions like:   speed * lag()
return delta_time * room_speed * 0.000001
