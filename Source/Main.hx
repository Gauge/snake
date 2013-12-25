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

	public static var BOARDROWS = 25;
	public static var BOARDCOLS = 25;
	static var GAMESPEED = 5; // tiles per second
	public static var TILESIZE = 6;

	// user direction 
	static var UP = 1;
	static var DOWN = 2;
	static var RIGHT = 3;
	static var LEFT = 4;

	// game state
	static var GAMEPLAY = 1;
	static var GAMEPAUSED = 2;
	static var GAMEOVER = 3;
	var gameState:Int;
	var gameText:String;
	var gameSpeed:Int;

	// graphic and display
	var appleGraphic:Sprite;
	var snakeGraphic:Sprite;
	var gameBackground:Sprite;
	var titleBox:Sprite;
	var footerBox:Sprite;
	var scoreBox:TextField;

	var apple:Point;
	var appleEatten:Array <Point>;

	var snake:Array <Point>;
	var snakeDirection:Int;
	var score:Int;
	var frames:Int;
	var gameboardCorner:Point;


	public function new () {
		super();
		gameSpeed = 5;
		gameText = "SNAKE";
		snake = [new Point(0, 0), new Point(1, 0), new Point(2, 0)];
		appleEatten = [];
		snakeDirection = RIGHT;
		apple = randomApple();
		gameState = GAMEPLAY;
		score = 0;
		frames = 5;
		drawGUI();
		stage.addEventListener (Event.ENTER_FRAME, render);
		stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDown);
	}

	private function render(event:Event):Void {
		if (gameState != GAMEPAUSED){
			if (frames == gameSpeed){
				updateSnake();
				drawGUI();
				drawApple();
				drawSnake();

				frames = 0;
			}
			frames++;
		}

	}
	
	public function drawGUI():Void {
		var screenSize = new Point(stage.stageWidth, stage.stageHeight);
		var gameSize = new Point (TILESIZE * BOARDCOLS, TILESIZE * BOARDROWS);
		var gamePosition = new Point((screenSize.x / 2) - (gameSize.x / 2), (screenSize.y / 2) - (gameSize.y / 2));
		gameboardCorner = gamePosition;

		gameBackground = new Sprite();
		gameBackground.graphics.beginFill(0xA8A8A8, 1.0);
		gameBackground.graphics.drawRect(gamePosition.x, gamePosition.y, gameSize.x, gameSize.y);
		addChild(gameBackground);

		var titleSize = new Point(gameSize.x , 40);
		var titlePosition = new Point(gamePosition.x, gamePosition.y - 50);

		titleBox = new Sprite();
		titleBox.graphics.beginFill(0xA8A8A8, 1.0);
		titleBox.graphics.drawRoundRect(titlePosition.x, titlePosition.y, titleSize.x, titleSize.y, 5);
		addChild(titleBox);

		var titleText = new TextField();
		var textFormat = new TextFormat();
		titleText.width = titleSize.x - 80;
		titleText.height = titleSize.y + 10;
		titleText.x = titlePosition.x;
		titleText.y = titlePosition.y + 5;
		textFormat.align = TextFormatAlign.CENTER;
		titleText.defaultTextFormat = textFormat;
		titleText.text = gameText;
		titleBox.addChild(titleText);

		var scoreBox = new TextField();
		var scoreFormat = new TextFormat();
		scoreBox.width = 50;
		scoreBox.height = 60;
		scoreBox.x = titleText.x + titleText.width;
		scoreBox.y = titlePosition.y;
		scoreFormat.align = TextFormatAlign.CENTER;
		scoreBox.defaultTextFormat = scoreFormat;
		scoreBox.text = "Score: " + score;
		addChild(scoreBox);
	}

	private function drawSnake():Void {
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

	private function drawApple():Void {
		if(appleGraphic == null) appleGraphic = new Sprite();
		appleGraphic.graphics.clear();
		var x = (apple.x * TILESIZE) + gameboardCorner.x;
		var y = (apple.y * TILESIZE) + gameboardCorner.y;
		appleGraphic.graphics.beginFill(0xFF0000, 1.0);
		appleGraphic.graphics.drawRect(x, y, TILESIZE, TILESIZE);
		addChild(appleGraphic);

	}


	private function updateSnake():Void {
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
			checkForApple();
			growSnake();
		} 
		else {
			gameState = GAMEOVER;
		}
	}

	// checks to see if the location given is within the bounds of the board
	// and is not occupied by a snake piece
	private function isValidMove(x:Int, y:Int):Bool {
		if (x >= 0 && x < BOARDROWS &&
			y >= 0 && y < BOARDCOLS){
			for (i in 0...snake.length){
				if (snake[i].x == x && snake[i].y == y){
					return false;
				}
			}
			return true;
		} 
		return false;
	}

	private function checkForApple(){
		if(pointsOverlap(snake[snake.length-1], apple)){
			appleEatten.insert(0, apple);
			apple = randomApple();
			score++;
			
			if (score % 5 == 0){
				gameSpeed = (gameSpeed > 1) ? gameSpeed - 1 : gameSpeed;
				trace('subtracting gameSpeed');
			}
			trace(score + "_" + gameSpeed);
		}
	}

	private function randomApple():Point {
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

	private function pointsOverlap(point1:Point, point2:Point):Bool {
		if(point1.x == point2.x && point1.y == point2.y) return true;
		return false;
	}

	private function growSnake(){
		for (i in 0...appleEatten.length){
			if(pointsOverlap(appleEatten[i], snake[0])){
				snake.insert(0, appleEatten[i]);
				appleEatten.remove(appleEatten[i]);
			}
		}
	}

	private function keyDown(event:KeyboardEvent):Void {
		// get the first two sections of the snake to make sure a user can't
		// turn back on there own body
		var snakeHead = snake[snake.length-1];
		var snakeNeck = snake[snake.length-2];
		if (event.keyCode == Keyboard.ESCAPE) {
			if (gameState != GAMEOVER && gameState == GAMEPLAY){
				gameState = GAMEPAUSED;
				gameText = "PAUSED"; 		
			} else {
				gameState = GAMEPLAY;
				gameText = "SNAKE";
			}
			drawGUI();
			drawSnake();
			drawApple();
		}
		if (event.keyCode == Keyboard.A){
			snakeDirection = ((snakeHead.x-1) != snakeNeck.x) ? LEFT : snakeDirection;
		}
		if (event.keyCode == Keyboard.W){
			snakeDirection = ((snakeHead.y-1) != snakeNeck.y) ? UP : snakeDirection;
		}
		if (event.keyCode == Keyboard.S){
			snakeDirection = ((snakeHead.y+1) != snakeNeck.y) ? DOWN : snakeDirection;
		}
		if (event.keyCode == Keyboard.D){
			snakeDirection = ((snakeHead.x+1) != snakeNeck.x) ? RIGHT : snakeDirection;
		}
		if (event.keyCode == Keyboard.LEFT){
			snakeDirection = ((snakeHead.x-1) != snakeNeck.x) ? LEFT : snakeDirection;
		}
		if (event.keyCode == Keyboard.UP){
			snakeDirection = ((snakeHead.y-1) != snakeNeck.y) ? UP : snakeDirection;
		}
		if (event.keyCode == Keyboard.DOWN){
			snakeDirection = ((snakeHead.y+1) != snakeNeck.y) ? DOWN : snakeDirection;
		}
		if (event.keyCode == Keyboard.RIGHT){
			snakeDirection = ((snakeHead.x+1) != snakeNeck.x) ? RIGHT : snakeDirection;
		}
	}	
}