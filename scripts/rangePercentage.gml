///rangePercentage(input, range_min, range_max, range_2ndMax)

//"I put together this function to calculate it. It also gives the ability to set a mid way 100% point that then goes back down." - Daniel Tonon on Stack overflow   https://stackoverflow.com/questions/25835591/how-to-calculate-percentage-between-the-range-of-two-values-a-third-value-is/25835683

/*
*  [] = optional
*  rangePercentage(input, minimum_range, maximum_normal_range, [maximum_upper_range]);
*  
*  rangePercentage(250, 0, 500); //returns 50 (as in 50%)
*  
*  rangePercentage(100, 0, 200, 400); //returns 50
*  rangePercentage(200, 0, 200, 400); //returns 100 
*  rangePercentage(300, 0, 200, 400); //returns 50 
*/
var input = argument[0]
var range_max = argument[1]
var range_min = argument[2]
if (argument_count > 3) {var range_2ndMax = argument[3]}else{var range_2ndMax = undefined}

var percentage = ((input - range_min) * 100) / (range_max - range_min);

if (percentage > 100)
{
    if (typeof(range_2ndMax) != 'undefined')
    {
        percentage = ((range_2ndMax - input) * 100) / (range_2ndMax - range_max);
        if (percentage < 0)
        {
            percentage = 0;
        }
    } else {
        percentage = 100;
    }
} else if (percentage < 0)
{
    percentage = 0;
}

return percentage;

