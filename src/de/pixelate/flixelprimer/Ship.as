package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class Ship extends FlxSprite
	{		
		[Embed(source="../../../../assets/png/Ship.png")] private var ImgShip:Class;

		public function Ship():void
		{
			super(50, 50, ImgShip);
		}

		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;

			if(FlxG.keys.LEFT)
			{
				velocity.x = -250;
			}
			else if(FlxG.keys.RIGHT)
			{
				velocity.x = 250;				
			}

			if(FlxG.keys.UP)
			{
				velocity.y = -250;				
			}
			else if(FlxG.keys.DOWN)
			{
				velocity.y = 250;
			}
			
			super.update();
			
			if(x > FlxG.width-width-16)
			{
				x = FlxG.width-width-16;
			}
			else if(x < 16)
			{
				x = 16;				
			}

			if(y > FlxG.height-height-16)
			{
				y = FlxG.height-height-16;
			}
			else if(y < 16)
			{
				y = 16;				
			}	
		}
		
		public function getBulletSpawnPosition():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + 36, y + 12);
			return p;
		}		
	}
}