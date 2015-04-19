
import luxe.Color;
import luxe.components.sprite.SpriteAnimation;
import luxe.Input;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Scene;
import luxe.Sound;
import luxe.utils.Maths;
import luxe.Vector;
import luxe.resource.Resource;
import phoenix.Texture;

class Main extends luxe.Game {

    var hud:HUD;

    var player:Actor;
    var playerImage:Texture;

    // var people:Scene;
    var peopleImage:Texture;


    var music:Sound;
    

    override function ready() {

        Luxe.renderer.clear_color = new Color(0, 0, 0, 1);

        // people = new Scene('people');
        
        //fetch a list of assets to load from the json file
        Luxe.loadJSON('assets/parcel.json', function(json_asset) {

                //then create a parcel to load it for us
            var preload = new Parcel();
                preload.from_json(json_asset.json);

                //but, we also want a progress bar for the parcel,
                //this is a default one, you can do your own
            new ParcelProgress({
                parcel      : preload,
                background  : new Color(1,1,1,0.85),
                oncomplete  : assets_loaded
            });

                //go!
            preload.load();

        });

    } //ready


    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup


    override function onkeydown( e:KeyEvent ) {
        if(e.keycode == Key.key_p
        || e.keycode == Key.kp_plus
        || e.keycode == Key.equals
        || e.keycode == Key.kp_backspace){
            trace('Key.plus');
            if(music.volume < 0.9){
                music.volume += 0.5;
            }
        }
        if(e.keycode == Key.key_o
        || e.keycode == Key.minus
        || e.keycode == Key.kp_minus
        || e.keycode == Key.kp_b ){
            trace('Key.minus');
            if(music.volume > 0.1){
                music.volume -= 0.5;
            }
        }
        trace('Key.kp_backspace = ${Key.kp_backspace}');
        trace('Key.kp_b = ${Key.kp_b}');
        trace('e.keycode = ${e.keycode}');
        trace('music.volume: ${music.volume}');
    }




    function assets_loaded(_) {

        Director.init_director();

        trace('assets_loaded()');

        create_hud();
        create_player();
        create_people();

        play_music();


    } //assets_loaded

    function level_loaded(_) {

        create_people();
    }

    function create_hud() {
        hud = new HUD({name:'hud'});
        // hud.hud_batcher.enabled = true;
        // Luxe.renderer.add_batch(hud.hud_batcher);
    }


    function create_player() {

        playerImage = Luxe.loadTexture('assets/player.png');
        playerImage.filter = nearest;

        player = new Actor({
            name: 'player',
            texture: playerImage,
            pos: new Vector(Director.bounds.w/2, Director.bounds.h/2),
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

        peopleImage = Luxe.loadTexture('assets/people.png');
        peopleImage.filter = nearest;

        var _x:Float;
        var _y:Float;

        for(i in 0...50){
            _x = Maths.random_float(32, Director.bounds.w-32);
            _y = Maths.random_float(32, Director.bounds.h-32);

            spawn_man( new Vector(_x, _y) );
        }

    }

    function spawn_man( _pos:Vector )
    {
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
        man.add(new components.MoverWalking({name: 'walking', maxWalkSpeed: Maths.random_float(5,30)}));
        man.add(new components.Bounds({name: 'bounds'}));
        man.add(new components.Collider({
            name: 'collider',
            name_actor: 'man',
            shape: luxe.collision.shapes.Polygon.rectangle(0,0,16,16,true)
        }));
        man.add(new components.Feelings({name: 'feelings'}));

        var anim_object = Luxe.loadJSON('assets/peopleanim.json');

            //create the animation component and add it to the sprite
        var anim = man.add( new SpriteAnimation({ name:'anim' }) );

            //create the animations from the json
        anim.add_from_json_object( anim_object.json );
    }




    function play_music()
    {
        Luxe.audio.create("assets/music/boomboxmusic.ogg", 'music', true).then(function(sound:Sound) {
            music = sound;
            music.loop();
        });
    }


    override function update(dt:Float) {

    } //update


} //Main
