/// @description Insert description here
// You can write your code in this editor
instance_deactivate_all(true); //Deactivate all other instances
    instance_activate_region(camera_get_view_x(view_camera[0])-64,camera_get_view_y(view_camera[0])-64,camera_get_view_width(view_camera[0])+128,camera_get_view_height(view_camera[0])+128,true); //Activate all instances just outside of the view
    instance_deactivate_object(o_parentEnemy); //Deactivate enemies
    instance_activate_region(camera_get_view_x(view_camera[0])-32,camera_get_view_y(view_camera[0])-32,camera_get_view_width(view_camera[0])+32,camera_get_view_height(view_camera[0]),true); //Activate all instances inside view
	
var _cam_x = camera_get_view_x(view_camera[0]) ;
layer_x("Background", _cam_x * 0.5); // Change the background layer name to whatever you use in the room editor
layer_x("Backgrounds_1", _cam_x * 0.25);
room_speed=60;
enum states {
			idleright,
			idleleft,
			walkingright,
			walkingleft,
			jumpingright,
			jumpingleft,
			idleshootright,
			idleshootleft,
			walkingshootright,
			walkingshootleft,
			jumpnshootright,
			jumpnshootleft}
enum shots {
			normal,
			fire,
			ice}
			grv=0.3*global.bullettime;
if(global.life<=0)
{
	game_restart();
}

prevstate=state;
//input checking
keyup= keyboard_check(vk_up)||keyboard_check(ord("W"));
keydown = keyboard_check(vk_down)||keyboard_check(ord("S"));
keydownheld = keyboard_check_pressed(vk_down)||keyboard_check_pressed("S");
keyleft= keyboard_check(vk_left)||keyboard_check(ord("A"));
keyright = keyboard_check(vk_right)||keyboard_check(ord("D"));
keyjump=keyboard_check_pressed(vk_space);
keyjumpheld=keyboard_check(vk_space);
keydown=keyboard_check(vk_down)||keyboard_check(ord("S"));
key1=keyboard_check(ord("1")); 
key2=keyboard_check(ord("2"));
key3=keyboard_check(ord("3"));
if(key1)
shotstate=shots.normal;
else
if(key2)
shotstate=shots.fire;
else
if(key3)
shotstate=shots.ice;
//Animation FSM
if(!place_meeting(x,y+2,o_Platform)&&!keyleft&&!keyright)
{
	if(prevstate==states.idleleft||prevstate==states.jumpingleft||prevstate==states.walkingleft||prevstate ==states.idleshootleft||prevstate==states.walkingshootleft||prevstate==states.jumpnshootleft)
	{
		state = states.jumpingleft
	}
	if(prevstate==states.idleright||prevstate==states.jumpingright||prevstate==states.walkingright||prevstate ==states.idleshootright||prevstate==states.walkingshootright||prevstate==states.jumpnshootright)
	{
		state = states.jumpingright;	
	}
}
if(!keyleft&&!keyright&&place_meeting(x,y+2,o_Platform))
	{
	if(prevstate==states.walkingright||prevstate==states.jumpingright||prevstate ==states.idleshootright||prevstate==states.walkingshootright||prevstate==states.jumpnshootright)
		{
			state=states.idleright;
		}
	if(prevstate == states.walkingleft||prevstate==states.jumpingleft||prevstate ==states.idleshootleft||prevstate==states.walkingshootleft||prevstate==states.jumpnshootleft)
		{
			state=states.idleleft;
		}
		
	}
if(keyjump||!place_meeting(x,y+2,o_Platform))
{
	if(prevstate==states.idleleft||prevstate==states.walkingleft||prevstate==states.jumpingleft||prevstate ==states.idleshootleft||prevstate==states.walkingshootleft||prevstate==states.jumpnshootleft)
		{state=states.jumpingleft;}
	if(prevstate==states.idleright||prevstate==states.walkingright||prevstate==states.jumpingright||prevstate ==states.idleshootright||prevstate==states.walkingshootright||prevstate==states.jumpnshootright)
		{state=states.jumpingright;}
}
if(keyleft&&!keyright&&place_meeting(x,y+2,o_Platform))
	{
		if(prevstate==states.walkingright||prevstate==states.jumpingright||prevstate==states.idleright||prevstate ==states.idleshootright||prevstate==states.walkingshootright||prevstate==states.jumpnshootright)
		{
		//	x=x-32;	
		}
		state=states.walkingleft;
		}
if(keyright&&!keyleft&&place_meeting(x,y+2,o_Platform))
	{
		if(prevstate==states.walkingleft||prevstate==states.jumpingleft||prevstate==states.idleleft||prevstate ==states.idleshootleft||prevstate==states.walkingshootleft||prevstate==states.jumpnshootleft)
		{

			//x=x+32;	
				
		}
		state=states.walkingright;
	}
if(keyright&&keyleft&&place_meeting(x,y+2,o_Platform))
{
if(prevstate==states.walkingleft||prevstate=states.jumpingleft||prevstate ==states.idleshootleft||prevstate==states.walkingshootleft||prevstate==states.jumpnshootleft)
	{
	state=states.idleleft;
	}
	if(prevstate==states.walkingright||prevstate=states.jumpingright||prevstate ==states.idleshootright||prevstate==states.walkingshootright||prevstate==states.jumpnshootright)
	{
	state=states.idleright;
	}
}
if(keyleft&&!keyright&&!place_meeting(x,y+2,o_Platform)&&(prevstate==states.jumpingright||prevstate==states.jumpnshootright))
{state = states.jumpingleft;
	//	x=x-32;
		}
if(!keyleft&&keyright&&!place_meeting(x,y+2,o_Platform)&&(prevstate==states.jumpingleft||prevstate==states.jumpnshootleft))
{state = states.jumpingright;
//	x=x+32;
	}
	if(state=states.idleright&&mouse_check_button(mb_left))
		{
		state=states.idleshootright;
		}
		else
		if(state=states.idleleft&&mouse_check_button(mb_left))
		{
		state=states.idleshootleft;
		}
		else
		if(state=states.walkingright&&mouse_check_button(mb_left))
		{
		state=states.walkingshootright;
		}
		else
		if(state=states.walkingleft&&mouse_check_button(mb_left))
		{
		state=states.walkingshootleft;
		}
		else
		if(state=states.jumpingright&&mouse_check_button(mb_left))
		{
		state=states.jumpnshootright;
		}
		else
		if(state=states.jumpingleft&&mouse_check_button(mb_left))
		{
		state=states.jumpnshootleft;
		}
switch(state){
case states.idleright:{image_xscale =1; {index=0;} break;}
case states.idleleft:{image_xscale =-1; {index=0;} break;}
case states.walkingright:{image_xscale =1;if(index>0&&index<4){ index=index+0.15*global.bullettime} else {index=1;} break;}
case states.walkingleft:{image_xscale =-1;if(index>0&&index<4) {index=index+0.15*global.bullettime} else {index=1;} break;}
case states.jumpingright:{image_xscale =1;{index=0;} break;}
case states.jumpingleft:{image_xscale =-1;{index=0;}  break;}
case states.idleshootright:{image_xscale =1;{index=5;} break;}
case states.idleshootleft:{image_xscale =-1;{index=5;} break;}
case states.walkingshootright:{image_xscale =1;if(index>0&&index<4){ index=index+0.15*global.bullettime} else {index=1;} break;}
case states.walkingshootleft:{image_xscale =-1;if(index>0&&index<4) {index=index+0.15*global.bullettime} else {index=1;} break;}
case states.jumpnshootright:{image_xscale =1;{index=5;} break;}
case states.jumpnshootleft:{image_xscale =-1;{index=5;}  break;}
}

move = keyright - keyleft;
hsp = move *walksp;
if(place_meeting(x,y+1,o_Platform)&&keyjump&&stuck==0&&stuckvertical==0&&(anim_speed>30||anim_speed==0)&&round(vsp)==0)
{									//if you are touching the  ground and you are not stuck
	canleap=1;						//you can jump
	if(global.bullettime==1)
		vsp=-9
	else
		vsp=-9*global.bullettime*2;
}
if(stuckcounter==0&&stuck==0&&stuckvertical==0&&(anim_speed>30||anim_speed==0))
if(!place_meeting(x+hsp,y-1,o_NowayWall)){	//if you are not stuck move
if(global.bullettime!=1)
				x=x+(hsp*global.bullettime);
			else
				x=x+(hsp*global.bullettime);
}
event_inherited();
if(hurt==1)
	{
	if((anim_speed>=0&&anim_speed<=10)||(anim_speed>=20&&anim_speed<=30)||(anim_speed>=40&&anim_speed<=50))
	{alpha=0;}
	else{alpha=1;}
	}
	else {alpha=1;}
if(anim_speed>=60/global.bullettime)
	{
	hurt=0;
	anim_speed=0;
	}
if(!keyjumpheld==1&&vsp<0&&jumpenemy==0)	//while jump key ius held keep rising  until peak
	vsp=max(vsp,0);
	
if(stuckvertical==0)
y =	y +vsp*global.bullettime;		//if you are not stuck  move

if(hurt)
anim_speed++;

if(state == states.walkingleft||state==states.idleleft||state==states.jumpingleft||state==states.idleshootleft||state==states.jumpnshootleft||state==states.walkingshootleft)
	{dir=-1;}
	else
	{dir=1;}

if(anim_speed<=30&&anim_speed>0)												//hurt duration in which you will be moved back opposite to the direction of attack
{
	if(!place_meeting(x+5*hurtdir,y-5,o_NowayWall))
	{
		x=x+hurtdir*2*global.bullettime;
	}
}