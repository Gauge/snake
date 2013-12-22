package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.geom.Point;



class Main extends Sprite {

	static var GAMEROWS = 40;
	static var GAMECOLS = 40;
	static var TILESIZE = 5;
	static var GAMENAME = "SNAKE";
	static var STARTSPEED = 5; // tiles per second

	static var up = "up";
	static var down = "down";
	static var right = "right";
	static var left = "left";

	var gameState:String;
	
	var apple:Point;
	var apple:Graphic:Sprite;
	var appleEatten:Bool;
	var snake:Array <Array <Point>>;
	var snakeGraphic:Sprite;
	var snakeDirection:String;
	var score:Int;

	var gameBackground:Sprite;
	var titleBox:Sprite;
	var footerBox:Sprite;
	var scoreBox:TextField;


	
	public function new () {
		
		super ();
		
		
		
	}
	
	
}