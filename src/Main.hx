
import luxe.Color;
import luxe.Input;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Scene;
import luxe.Sound;
import luxe.States;
import luxe.utils.Maths;
import luxe.Vector;
import luxe.resource.Resource;
import phoenix.Texture;

class Main extends luxe.Game {

    public static var state:States;

    public static var levels:Int;
    public static var score:Int;
    public static var dead:Int;
    public static var playtime:Float;

    override function ready() {

        Main.levels = 0;
        Main.score = 0;
        Main.dead = 0;
        Main.playtime = 0;

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


    function assets_loaded(_) {

        trace('assets_loaded()');

        Luxe.camera.zoom = 3;
        Luxe.camera.pos.x = -Luxe.screen.w/Luxe.camera.zoom;
        Luxe.camera.pos.y = -Luxe.screen.h/Luxe.camera.zoom;

        state = new States({ name:'state' });

        state.add( new Logo() );
        state.add( new Madewith() );
        state.add( new Menu() );
        state.add( new Game() );
        state.add( new GameOver() );
        state.set('logo');

        Luxe.renderer.clear_color = new Color(0, 0, 0, 1);

    } //assets_loaded



    



} //Main
