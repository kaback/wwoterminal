#!/usr/bin/perl -w
use strict;
use warnings;
use LWP::Simple;

my $content = get('http://www.worldweatheronline.com/Grossenehrich-weather/Thuringen/DE.aspx') or die 'Unable to get page';
$content =~ /weather_forecastdiv(.*?)LTF/s;
my $three_days = $1;

$content =~ /.*?Latest Weather Observations(.*?)Humidity.*/s;
my $wind = $1;
$wind =~ /.*>(\d+ mph from the .*?)<.*/s;
print "Wind akt.: ",$1, "\n";

$three_days =~ /(.*?)Charts(.*?)Charts(.*?)Charts/s;

my $today = $1;
my $tomorrow = $2;
my $dayaftertomorrow = $3;

$today =~ /box_2.*?box_2.*?box_2.*?box_2(.*?)box_2/s;
my $temperature = $1;
$temperature =~ />(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*/s;
print "Vormi\tMitta\tNachm\tAbend\n";
print "$1\t$2\t$3\t$4\t(Temp heute °C)\n";

$tomorrow =~ /box_2.*?box_2.*?box_2.*?box_2(.*?)box_2/s;
$temperature = $1;
#print $temperature;
$temperature =~ />(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*/s;
print "$1\t$2\t$3\t$4\t(Temp morgen °C)\n";

$dayaftertomorrow =~ /box_2.*?box_2.*?box_2.*?box_2(.*?)box_2/s;
$temperature = $1;
#print $temperature;
$temperature =~ />(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*?<li>(-?\d*).*/s;
print "$1\t$2\t$3\t$4\t(Temp übermorgen °C)\n";
