<?php
define("SECOND", 1);
define("MINUTE", 60 * SECOND);
define("HOUR", 60 * MINUTE);
define("DAY", 24 * HOUR);
define("MONTH", 30 * DAY);

function relativeTime($datetm)
{   

   	$now = time();
	$delta = ($now) - strtotime($datetm);
	//echo "current time is".$now." timestamp".$datetm."diff in time".$delta;
    if ($delta < 1 * MINUTE)
    {
        return $delta == 1 ? "one second ago" : "Less than a minute ago";
    }elseif ($delta < 2 * MINUTE)
    {
      return "a minute ago";
    }elseif ($delta < 45 * MINUTE)
    {
        return floor($delta / MINUTE) . " minutes ago";
    }elseif ($delta < 90 * MINUTE)
    {
      return "an hour ago";
    }elseif ($delta < 24 * HOUR)
    {
      return floor($delta / HOUR) . " hours ago";
    }elseif ($delta < 48 * HOUR)
    {
      return "yesterday";
    }elseif ($delta < 30 * DAY)
    {
        return floor($delta / DAY) . " days ago";
    }elseif ($delta < 12 * MONTH)
    {
      $months = floor($delta / DAY / 30);
      return $months <= 1 ? "one month ago" : $months . " months ago";
    }
    else
    {
        $years = floor($delta / DAY / 365);
        return $years <= 1 ? "one year ago" : $years . " years ago";
    }
}  
  
?>