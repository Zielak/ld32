package ;

import luxe.components.sprite.SpriteAnimation;
import luxe.Entity;
import luxe.Rectangle;
import luxe.Sound;
import luxe.tween.Actuate;
import luxe.utils.Maths;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;
import phoenix.Texture;
import luxe.Input;


class Game extends State {

    public static var hud:HUD;

    public static var level:Int;
    public static var peopleCount:Int;
    public static var deadCount:Int;
    public static var happyCount:Int;

    var player:Actor;
    var playerImage:Texture;
    var peopleImage:Texture;

    static public var bounds:Rectangle;

    static public var time:Float;
    static public var timeText:String;
    static var _seconds:Float;
    static var _minutes:Float;

    var music:Float;
    var musicSound:Sound;

    var nextlevelSound:Sound;

    public function new()
    {
        super({ name:'game' });

        // player
        playerImage = Luxe.loadTexture('assets/player.png');
        playerImage.filter = nearest;

        // people!
        peopleImage = Luxe.loadTexture('assets/people.png');
        peopleImage.filter = nearest;



        // Next level sound
        Luxe.audio.on("nextlevel", "load", function(e){
            nextlevelSound = e;
            nextlevelSound.volume = 0.4;
        });

    }

    override function onenter<T>(_:T) 
    {
        // trace('game onenter');
        Luxe.renderer.clear_color.tween(2,{ r:0.1,g:0.1,b:0.1 });

        Game.level = 1;
        music = 0.8;
        time = 10;
        _seconds = 0;
        _minutes = 0;

        Game.peopleCount = 0;

        bounds = new Rectangle(0,0,Luxe.screen.w/(Luxe.camera.zoom), Luxe.screen.h/(Luxe.camera.zoom));

        // trace('bounds : ${bounds}');
        // trace('Luxe.camera.pos : ${Luxe.camera.pos}');

        create_hud();

        init_events();

        play_music();
        next_level();
    }

    override function onleave<T>(_:T)
    {
        // trace('game onleave');
        Game.hud.destroy();
        player.destroy();


        // Remove all people
        var arr:Array<Entity> = new Array<Entity>();
        Luxe.scene.get_named_like('man', arr);
        for(e in arr){
            e.destroy();
        }

        // Remove all bullets
        arr = new Array<Entity>();
        Luxe.scene.get_named_like('bullet', arr);
        for(e in arr){
            e.destroy();
        }


        Luxe.events.clear();

        // Luxe.events.disconnect('people.death');
        // Luxe.events.disconnect('people.happy');
        // Luxe.events.disconnect('nextlevel');


        // Luxe.events.disconnect('game.happy.text');
        // Luxe.events.disconnect('game.time.text');
        // Luxe.events.disconnect('game.dead.text');

        stop_music();
    }




    override function onkeydown( e:KeyEvent ) {
        if(e.keycode == Key.key_p
        || e.keycode == Key.kp_plus
        || e.keycode == Key.equals
        || e.keycode == 187
        || e.keycode == Key.kp_backspace){
            // trace('Key.plus');
            if(music < 0.9){
                music += 0.05;
                musicSound.volume = music;
                // Luxe.audio.volume('music', music);
            }
        }
        if(e.keycode == Key.key_o
        || e.keycode == Key.minus
        || e.keycode == Key.kp_minus
        || e.keycode == 189
        || e.keycode == Key.kp_b ){
            // trace('Key.minus');
            if(music > 0.02){
                music -= 0.05;
                musicSound.volume = music;
                // Luxe.audio.volume('music', music);
            }
        }
        // trace('music = ${music}');
    }

    override function onkeyup( e:KeyEvent ) {

        // if(e.keycode == Key.escape) {
        //     Main.state.set('menu');
        // }

    } //onkeyup



    override function update( dt:Float )
    {

        Game.staticupdate( dt );

    } //update



    function init_events()
    {
        // trace('init_events');

        Luxe.events.listen('people.death', function(_){
            Game.deadCount ++;
            Main.dead ++;
            Luxe.events.fire('game.dead.text');
        });
        Luxe.events.listen('people.happy', function(_){
            Game.happyCount ++;
            Main.score ++;
            Luxe.events.fire('game.happy.text');

            // Flash the screen for a moment
            Luxe.renderer.clear_color.set(Maths.random_float(0.1,0.2), Maths.random_float(0.1,0.2), Maths.random_float(0.1,0.2), 1);
            Luxe.renderer.clear_color.tween(1,{ r:0.05, g:0.05, b:0.05 });

        });
        Luxe.events.listen('nextlevel', function(_){
            next_level();
        });
    }


    function create_hud() {
        trace('game create_hud');
        Game.hud = new HUD({name:'hud'});
    }


    function create_player() {
        trace('game create_player');

        player = new Actor({
            name: 'player',
            texture: playerImage,
            pos: new Vector(Game.bounds.w/2, Game.bounds.h/2),
            size: new Vector(16,16),
        });

        player.add(new components.Player({name: 'player'}));
        player.add(new components.InputPlayer({name: 'input'}));
        player.add(new components.MoverWalking({name: 'walking'}));
        player.add(new components.Bounds({name: 'bounds'}));
        player.add(new components.Shooting({name: 'shooting'}));

        var anim_object = Luxe.loadJSON('assets/playeranim.json');

            //create the animation component and add it to the sprite
        var anim = player.add( new SpriteAnimation({ name:'anim' }) );

            //create the animations from the json
        anim.add_from_json_object( anim_object.json );

            //set the idle animation to active
        anim.animation = 'down';
        anim.play();
    }


    // creates random people for now
    // TODO - load from level
    function create_people()
    {
        trace('game create_people');
        var _x:Float;
        var _y:Float;

        Game.peopleCount = (level * 2) + 5;

        for(i in 0...peopleCount){
            _x = Maths.random_float(32, Game.bounds.w-32);
            _y = Maths.random_float(32, Game.bounds.h-32);

            spawn_man( new Vector(_x, _y) );
        }

    }

    function spawn_man( _pos:Vector )
    {
        trace('game spawn_man');
        var man = new Actor({
            name: 'man',
            name_unique: true,
            texture: peopleImage,
            pos: _pos,
            size: new Vector(16,16),
            // scene: people,
        });

        man.add(new components.InputAI({name: 'input'}));
        man.add(new components.AIController({name: 'controller'}));
        man.add(new components.MoverWalking({name: 'walking', maxWalkSpeed: Maths.random_float(20,100)}));
        man.add(new components.Bounds({name: 'bounds'}));
        man.add(new components.Collider({
            name: 'collider',
            name_actor: 'man',
            shape: luxe.collision.shapes.Polygon.rectangle(0,0,16,16,true)
        }));
        trace('components.Feelings');
        man.add(new components.Feelings({name: 'feelings'}));

        var anim_object = Luxe.loadJSON('assets/peopleanim.json');

            //create the animation component and add it to the sprite
        var anim = man.add( new SpriteAnimation({ name:'anim' }) );

            //create the animations from the json
        anim.add_from_json_object( anim_object.json );
    }


    function play_music()
    {
        trace('game play_music');
        // var load = snow.api.Promise.all([
        //     Luxe.audio.create('assets/music/boomboxmusic.ogg', 'music')
        // ]);

        // load.then(function(_) {

        //         //start playing the music
        //     Luxe.audio.loop('music');
        //     Luxe.audio.volume('music', music);

        // }); //load.then
        

        // Music sound
        Luxe.audio.on("music", "load", function(e){
            musicSound = e;
            musicSound.volume = music;
            musicSound.loop();
        });

        trace('game play_music END');
    }

    function stop_music()
    {
        trace('game stop_music');
        musicSound.stop();
        // Luxe.audio.stop('music');
    }




    function next_level()
    {
        trace('game next_level');
        // Interface
        level++;
        Main.levels++;

        // Remove all people
        var arr:Array<Entity> = new Array<Entity>();
        Luxe.scene.get_named_like('man', arr);
        for(e in arr){
            e.destroy();
        }

        // Remove all bullets
        arr = new Array<Entity>();
        Luxe.scene.get_named_like('bullet', arr);
        for(e in arr){
            e.destroy();
        }


        Game.time = 10;
        _seconds = 0;
        _minutes = 0;


        Game.deadCount = 0;
        Game.happyCount = 0;

        Luxe.events.fire('game.happy.text');
        Luxe.events.fire('game.dead.text');
        



        // Scene
        if(player!=null) player.destroy();

        create_player();
        create_people();

        trace('b4 nextlevelSound.play');
        nextlevelSound.play();
        trace('after nextlevelSound.play');
    }














    static public function staticupdate(dt:Float)
    {
        Game.time -= dt;
        // trace(Main.playtime);
        Main.playtime += dt;
        
        updateTimeText();

        if(Game.time <= 0){
            Luxe.events.fire('game.over');
            Main.state.set('gameover');
        }
        if(Game.peopleCount == Game.deadCount+Game.happyCount)
        {
            Luxe.events.fire('nextlevel');
        }
    }

    static function updateTimeText()
    {
        _minutes = Math.floor(Game.time / 60);
        _seconds = Math.floor(Game.time - _minutes * 60);
        timeText = '${_minutes}:${_seconds}';

        Luxe.events.fire('game.time.text', timeText);
    }
}