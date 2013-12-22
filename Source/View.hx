
package ;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.geom.Point;
import flash.Lib;
import openfl.Assets;

class View extends Main {

	public static var TILESIZE = 5;

	var appleGraphic:Sprite;
	var snakeGraphic:Sprite;
	var gameBackground:Sprite;
	var titleBox:Sprite;
	var footerBox:Sprite;
	var scoreBox:TextField;

	public function new (){
		super();
	}
	
	
	public function drawGUI():Void{
		var screenSize = new Point(stage.stageWidth, stage.stageHeight);
		var gameSize = new Point (TILESIZE * Main.BOARDCOLS, TILESIZE * Main.BOARDROWS);
		var gamePosition = new Point((gameSize.x / 2) + (screenSize.x / 2), (gameSize.y / 2) + (screenSize.y / 2));

		gameBackground = new Sprite();
		gameBackground.graphics.beginFill(0xA8A8A8, 1.0);
		gameBackground.graphics.drawRect(gamePosition.x, gamePosition.y + 50, gameSize.x, gameSize.y);
		addChild(gameBackground);

		var titleSize = new Point(gameSize.x - 80, 40);
		var titlePosition = new Point(gamePosition.x, gamePosition.y - 50);

		titleBox = new Sprite();
		titleBox.graphics.beginFill(0xA8A8A8, 1.0);
		titleBox.graphics.drawRoundRect(titlePosition.x, titlePosition.y, titleSize.x, titleSize.y, 8);
		addChild(titleBox);

		var titleText = new TextField();


	}

}