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

class Main extends Sprite {

	public static var BOARDROWS = 40;
	public static var BOARDCOLS = 40;
	static var GAMENAME = "SNAKE";
	static var GAMESPEED = 5; // tiles per second
	public static var TILESIZE = 5;

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
	
	// graphic and display
	var appleGraphic:Sprite;
	var snakeGraphic:Sprite;
	var gameBackground:Sprite;
	var titleBox:Sprite;
	var footerBox:Sprite;
	var scoreBox:TextField;

	var apple:Point;
	var appleEatten:Point;

	var snake:Array <Point>;
	var snakeDirection:Int;
	var score:Int;
	var frames:Int;

	public function new () {
		super();
		snake = [new Point(0, 0), new Point(1, 0), new Point(2, 0)];
		snakeDirection = RIGHT;
		apple = randomApple();
		gameState = GAMEPLAY;
		score = 0;
		frames = 15;
		drawGUI();
		//stage.addEventListener (Event.ENTER_FRAME, render);
	}

	public function render():Void {
		if (frames == 15){
			updateSnake();
			drawSnake();
			drawApple();
			frames = 0;
		}
		frames++;
	}
	
	public function drawGUI():Void {
		trace('made it here');
		var screenSize = new Point(stage.stageWidth, stage.stageHeight);
		var gameSize = new Point (TILESIZE * BOARDCOLS, TILESIZE * BOARDROWS);
		var gamePosition = new Point((screenSize.x / 2) - (gameSize.x / 2), (screenSize.y / 2) - (gameSize.y / 2));

		gameBackground = new Sprite();
		gameBackground.graphics.beginFill(0xA8A8A8, 1.0);
		gameBackground.graphics.drawRect(gamePosition.x, gamePosition.y, gameSize.x, gameSize.y);
		addChild(gameBackground);

		var titleSize = new Point(gameSize.x - 80, 40);
		var titlePosition = new Point(gamePosition.x, gamePosition.y - 50);
		trace(titlePosition.y);

		titleBox = new Sprite();
		titleBox.graphics.beginFill(0xA8A8A8, 1.0);
		titleBox.graphics.drawRoundRect(titlePosition.x, titlePosition.y, titleSize.x, titleSize.y, 5);
		addChild(titleBox);

		var titleText = new TextField();
		titleText.width = titleSize.x - 20;
		titleText.height = titleSize.y - 10;
	}

	public function drawSnake():Void {

	}

	public function drawApple():Void {

	}


	public function updateSnake():Void {
		var x:Int, y:Int, xOffset:Int, yOffset:Int;
		xOffset = 0;
		yOffset = 0;

		if (snakeDirection == UP){
			xOffset = -1;
		} else if (snakeDirection == DOWN){
			xOffset = 1;
		} else if (snakeDirection == LEFT){
			yOffset = -1;
		} else if (snakeDirection == RIGHT){
			yOffset = 1;
		}

		x = Math.floor(snake[snake.length-1].x+xOffset);
		y = Math.floor(snake[snake.length-1].y+yOffset);

		if (isValidMove(x, y)){
			snake.push(new Point(x, y));
			snake.shift();
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

	public function getKeyboardInput():Void {

	}	
}