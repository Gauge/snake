package;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import flash.geom.Point;
import flash.Lib;
import openfl.Assets;

class Main extends Sprite {

	public static var BOARDROWS = 40;
	public static var BOARDCOLS = 40;
	static var GAMENAME = "SNAKE";
	static var GAMESPEED = 5; // tiles per second
	public static var TILESIZE = 6;

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
	var gameboardCorner:Point;


	public function new () {
		super();
		snake = [new Point(0, 0), new Point(1, 0), new Point(2, 0)];
		snakeDirection = RIGHT;
		apple = randomApple();
		gameState = GAMEPLAY;
		score = 0;
		frames = 8;
		drawGUI();
		stage.addEventListener (Event.ENTER_FRAME, render);
		stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDown);
	}

	public function render(event:Event):Void {
		if (frames == 8){
			updateSnake();
			drawApple();
			drawSnake();
			
			frames = 0;
		}
		frames++;

		if(appleEatten != null){

		}
	}
	
	public function drawGUI():Void {
		trace('made it here');
		var screenSize = new Point(stage.stageWidth, stage.stageHeight);
		var gameSize = new Point (TILESIZE * BOARDCOLS, TILESIZE * BOARDROWS);
		var gamePosition = new Point((screenSize.x / 2) - (gameSize.x / 2), (screenSize.y / 2) - (gameSize.y / 2));
		gameboardCorner = gamePosition;

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
		var format = new TextFormat();
		titleText.width = titleSize.x + 10;
		titleText.height = titleSize.y + 10;
		titleText.x = titlePosition.x;
		titleText.y = titlePosition.y + 5;
		format.align = TextFormatAlign.CENTER;
		titleText.defaultTextFormat = format;
		titleText.text = GAMENAME;
		titleBox.addChild(titleText);


		//var scoreSize = new Point(titlePosition.x + )
	}

	public function drawSnake():Void {
		if (snakeGraphic == null) snakeGraphic = new Sprite();
		snakeGraphic.graphics.clear();
		for(i in 0...snake.length) {
			var x = (snake[i].x * TILESIZE) + gameboardCorner.x;
			var y = (snake[i].y * TILESIZE) + gameboardCorner.y;

			snakeGraphic.graphics.beginFill(0x000000, 1.0);
			snakeGraphic.graphics.drawRect(x, y, TILESIZE, TILESIZE);
			addChild(snakeGraphic);
		}

	}

	public function drawApple():Void {
		if(appleGraphic == null) appleGraphic = new Sprite();
		appleGraphic.graphics.clear();
		var x = (apple.x * TILESIZE) + gameboardCorner.x;
		var y = (apple.y * TILESIZE) + gameboardCorner.y;
		appleGraphic.graphics.beginFill(0xFF0000, 1.0);
		appleGraphic.graphics.drawRect(x, y, TILESIZE, TILESIZE);
		addChild(appleGraphic);

	}


	public function updateSnake():Void {
		var x:Int, y:Int, xOffset:Int, yOffset:Int;
		xOffset = 0;
		yOffset = 0;

		if (snakeDirection == UP) yOffset = -1;
		else if (snakeDirection == DOWN) yOffset = 1;
		else if (snakeDirection == LEFT) xOffset = -1;
		else if (snakeDirection == RIGHT) xOffset = 1;

		x = Math.floor(snake[snake.length-1].x+xOffset);
		y = Math.floor(snake[snake.length-1].y+yOffset);

		if (isValidMove(x, y)){
			snake.push(new Point(x, y));
			snake.shift();
		} 
		else {
			gameState = GAMEOVER;
		}
	}

	// checks to see if the location given is within the bounds of the board
	// and is not occupied by a snake piece
	public function isValidMove(x:Int, y:Int):Bool {
		if (x >= 0 && x < BOARDROWS &&
			y >= 0 && y < BOARDCOLS){
			checkForApple();
			for (i in 0...snake.length){
				if (snake[i].x == x && snake[i].y == y){

					return false;
				}
			}
			return true;
		} 
		else {
			return false;
		} 
	}

	private function checkForApple(){
		//trace(snake[0]+" "+apple);
		if(snake[snake.length-1] == apple){
			trace("eatting");
			if(appleEatten == null) appleEatten = apple;
			apple = randomApple();
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

	public function keyDown(event:KeyboardEvent):Void {
		if (event.keyCode == Keyboard.A){
			snakeDirection = (snakeDirection != RIGHT) ? LEFT : RIGHT;
		}
		if (event.keyCode == Keyboard.W){
			snakeDirection = (snakeDirection != DOWN) ? UP : DOWN;
		}
		if (event.keyCode == Keyboard.S){
			snakeDirection = (snakeDirection != UP) ? DOWN : UP;
		}
		if (event.keyCode == Keyboard.D){
			snakeDirection = (snakeDirection != LEFT) ? RIGHT : LEFT;
		}
		if (event.keyCode == Keyboard.LEFT){
			snakeDirection = (snakeDirection != RIGHT) ? LEFT : RIGHT;
		}
		if (event.keyCode == Keyboard.UP){
			snakeDirection = (snakeDirection != DOWN) ? UP : DOWN;
		}
		if (event.keyCode == Keyboard.DOWN){
			snakeDirection = (snakeDirection != UP) ? DOWN : UP;
		}
		if (event.keyCode == Keyboard.RIGHT){
			snakeDirection = (snakeDirection != LEFT) ? RIGHT : LEFT;
		}

			
	}	
}