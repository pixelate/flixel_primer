package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class Bullet extends FlxSprite
	{		
		public function Bullet(x: Number, y: Number):void
		{
			super(x, y);
			createGraphic(16, 4, 0xFF597137);
			velocity.x = 1000;
		}
	}
}