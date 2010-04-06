package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{		
		[Embed(source="../../../../assets/mp3/ExplosionShip.mp3")] private var SoundExplosionShip:Class;
		[Embed(source="../../../../assets/mp3/ExplosionAlien.mp3")] private var SoundExplosionAlien:Class;
		[Embed(source="../../../../assets/mp3/Bullet.mp3")] private var SoundBullet:Class;

		private var _ship: Ship;
		private var _aliens: FlxGroup;
		private var _bullets: FlxGroup;		
		private var _scoreText: FlxText;
		private var _gameOverText: FlxText;
		private var _spawnTimer: Number;
		private var _spawnInterval: Number = 2.5;
		
		override public function create():void
		{
			FlxG.score = 0;
			
			bgColor = 0xFFABCC7D;
			
			_ship = new Ship();			
			add(_ship);
			
			_aliens = new FlxGroup();
			add(_aliens);
			
			_bullets = new FlxGroup();
			add(_bullets);

			_scoreText = new FlxText(10, 8, 200, "0");
			_scoreText.setFormat(null, 32, 0xFF597137, "left");
			add(_scoreText);
			
			resetSpawnTimer();
						
			super.create();
		}

		override public function update():void
		{			
			FlxU.overlap(_aliens, _bullets, overlapAlienBullet);
			FlxU.overlap(_aliens, _ship, overlapAlienShip);
			
			if(FlxG.keys.justPressed("SPACE") && _ship.dead == false)
			{
				spawnBullet(_ship.getBulletSpawnPosition());					
			}

			if(FlxG.keys.ENTER && _ship.dead)
			{				
				FlxG.state = new PlayState();
			}
			
			_spawnTimer -= FlxG.elapsed;
			
			if(_spawnTimer < 0)
			{
				spawnAlien();
				resetSpawnTimer();
			}
						
			super.update();
		}
		
		private function spawnAlien():void
		{
			var x: Number = FlxG.width;
			var y: Number = Math.random() * (FlxG.height - 100) + 50;
			_aliens.add(new Alien(x, y));
		}	
		
		private function spawnBullet(p: FlxPoint):void
		{
			var bullet: Bullet = new Bullet(p.x, p.y);
			_bullets.add(bullet);
			FlxG.play(SoundBullet);
		}	
		
		private function resetSpawnTimer():void
		{
			_spawnTimer = _spawnInterval;			
			_spawnInterval *= 0.95;
			if(_spawnInterval < 0.1)
			{
				_spawnInterval = 0.1;
			}
		}
		
		private function overlapAlienBullet(alien: Alien, bullet: Bullet):void
		{
			var emitter:FlxEmitter = createEmitter();
			emitter.at(alien);		
			alien.kill();
			bullet.kill();	
			FlxG.play(SoundExplosionAlien);	
			FlxG.score += 1;
			_scoreText.text = FlxG.score.toString();					
		}
		
		private function overlapAlienShip(alien: Alien, ship: Ship):void
		{
			var emitter:FlxEmitter = createEmitter();
			emitter.at(ship);			
			ship.kill();
			alien.kill();
			FlxG.quake.start(0.02);
			FlxG.play(SoundExplosionShip);	
			
			_gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");					
			_gameOverText.setFormat(null, 16, 0xFF597137, "center");
			add(_gameOverText);
		}
				
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-500, 500);
			emitter.setYSpeed(-500, 500);		
			var particles: int = 10;
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFF597137);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;		
		}
	}
}