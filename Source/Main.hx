package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.geom.Point;
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

	// init game
	public function new () {
		super ();
		snake = [new Point(0, 0), new Point(1, 0), new Point(2, 0)];
		apple = randomApple();
		render();
	}

public function render():Void{}

public function drawGUI():Void{}

public function drawSnake():Void{}

public function drawApple():Void{}

public function updateSnake():Void{}

public function isValidMove():Bool{}

public function randomApple():Point {
	// get random location
	var x = Std.random(GAMEROWS);
	var y = Std.random(GAMECOLS):
	// check to see if there is a snake at that location
	var isFound = false;
	for (i in 0...snake.length){
		if (snake[i].x == x && snake[i].y == y) {
			isFound = true;
			break;
		}
	}
	// if the snake exists there get a new point
	// otherwise return the point
	return isFound ? randomApple() : new Point(x, y);

}

public function getKeyboardInput():Void{}

	
	
}