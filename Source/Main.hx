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

	public static var BOARDROWS = 40;
	public static var BOARDCOLS = 40;
	static var GAMENAME = "SNAKE";
	static var GAMESPEED = 5; // tiles per second
	
	// user direction 
	static var UP = 1;
	static var DOWN = 2;
	static var RIGHT = 3;
	static var LEFT = 4;

	// game state
	static var GAMEPLAY = 1;
	static var GAMEPASED = 2;
	static var GAMEOVER = 3;
	var gameState:Int;
	
	var apple:Point;
	var appleEatten:Point;

	var snake:Array <Point>;
	var snakeDirection:Int;
	var score:Int;

	public function new () {
		super ();
		snake = [new Point(0, 0), new Point(1, 0), new Point(2, 0)];
		snakeDirection = RIGHT;
		apple = randomApple();
		gameState = GAMEPLAY;
		score = 0;
		render();
	}

public function render():Void {}

public function updateSnake():Void {
	var x:Int, y:Int;
	var xOffset:Int;
	var yOffset:Int;
	xOffset = 0;
	yOffset = 0;

	if (snakeDirection == UP) {
		yOffset = -1;
	} else if (snakeDirection == DOWN) {
		yOffset = 1;
	} else if (snakeDirection == LEFT) {
		xOffset = -1;
	} else if (snakeDirection == RIGHT) {
		xOffset = 1;
	}
	// get location of the move
	x = Math.floor(snake[snake.length-1].x+xOffset);
	y = Math.floor(snake[snake.length-1].y+yOffset);
	// test to see if move is valid
	if (isValidMove(x, y)) {
		snake.shift();
		snake.push(new Point(x, y));
	} else {
		gameState = GAMEOVER;
	}
}

// checks to see if the location given is within the bounds of the board
// and is not occupied by a snake piece
public function isValidMove(x:Int, y:Int):Bool {
	if (x >= 0 && x < BOARDROWS &&
		y >= 0 && y < BOARDCOLS){

		for (i in 0...snake.length){
			if (snake[i].x == x && snake[i].y == y){
				return false;
			}
		}
		return true;
	
	} else {
		return false;
	} 
}

public function randomApple():Point {
	// get random location
	var x = Std.random(BOARDROWS);
	var y = Std.random(BOARDCOLS);
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