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
	static var GAMENAME = "SNAKE";
	static var GAMESPEED = 5; // tiles per second
	static var TILESIZE = 5;
	
	// user direction 
	static var UP = 1;
	static var DOWN = 2;
	static var RIGHT = 3;
	static var LEFT = 4;

	// game state
	static var GAMEPLAY = 1
	static var GAMEPASED = 2
	static var GAMEOVER = 3 
	var gameState:Int;
	
	// apple stuff
	var apple:Point;
	var apple:Graphic:Sprite;
	var appleEatten:Point;

	// snake stuff
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