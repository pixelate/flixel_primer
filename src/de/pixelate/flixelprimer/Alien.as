package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class Alien extends FlxSprite
	{		
		[Embed(source="../../../../assets/png/Alien.png")] private var ImgAlien:Class;

		public function Alien(x: Number, y: Number):void
		{
			super(x, y, ImgAlien);
			velocity.x = -200;
		}

		override public function update():void
		{			
	    	velocity.y = Math.cos(x / 50) * 50;
			super.update();			
		}	
	}
}