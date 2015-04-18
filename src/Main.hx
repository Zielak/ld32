
import luxe.Input;
import luxe.Scene;
import luxe.utils.Maths;
import luxe.Vector;
import phoenix.Texture;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Color;
import luxe.components.sprite.SpriteAnimation;

class Main extends luxe.Game {

    var hud:HUD;

    var player:Actor;
    var playerImage:Texture;

    var people:Scene;
    var peopleImage:Texture;

    

    override function ready() {

        Luxe.renderer.clear_color = new Color(0, 0, 0, 1);

        people = new Scene('people');
        
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


    function assets_loaded(_) {

        Director.init_director();

        trace('assets_loaded()');

        create_hud();
        create_player();
        create_people();


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

        for(i in 0...30){
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
            scene: people,
        });

        man.add(new components.InputAI({name: 'input'}));
        man.add(new components.AIController({name: 'controller'}));
        man.add(new components.MoverWalking({name: 'walking', maxWalkSpeed: Maths.random_float(5,30)}));
        man.add(new components.Bounds({name: 'bounds'}));
        man.add(new components.Feelings({name: 'feelings'}));

        var anim_object = Luxe.loadJSON('assets/peopleanim.json');

            //create the animation component and add it to the sprite
        var anim = man.add( new SpriteAnimation({ name:'anim' }) );

            //create the animations from the json
        anim.add_from_json_object( anim_object.json );
    }


    override function update(dt:Float) {

    } //update


} //Main
