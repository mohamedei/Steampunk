/// @description Insert description here
// You can write your code in this editor
if(global.xp>0)
{
global.bullettime=0.5;//start bullettime
firing_delay=firing_delay/global.bullettime;
bullettimecounter++;
vsp=vsp*global.bullettime;
if(bullettimecounter%30==0)
{
	global.xp-=10;
}
}
else
{
global.bullettime=1;
firing_delay=firing_delay*global.bullettime;
vsp=vsp/global.bullettime;
}