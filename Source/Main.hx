package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.geom.Point;
import flash.Lib;
import openfl.Assets;
import View;



class Main extends Sprite {

	static var GAMEROWS = 40;
	static var GAMECOLS = 40;
	static var GAMENAME = "SNAKE";
	static var GAMESPEED = 5; // tiles per second
	
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
	
	var apple:Point;
	var appleEatten:Point;

	var snake:Array <Array <Point>>;
	var snakeDirection:Int;
	var score:Int;
	
	public function new () {
		super ();



		
		
		
	}

public function initGame():Void{}

public function render():Void{}

public function drawSnake():Void{}

public function drawApple():Void{}

public function updateSnake():Void{}

public function isValidMove():Bool{}

public function randomApple():Void{}

public function getKeyboardInput():Void{}

	
	
}