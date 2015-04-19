package ;

import luxe.Input;
import luxe.Rectangle;
import luxe.tween.Actuate;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;
import phoenix.Texture.FilterType;


class Menu extends State {

    var screen:Sprite;
    var timer:Float;

    var canPlay:Bool;
    var twitterLink:Rectangle;

    public function new()
    {
        super({ name:'menu' });

        twitterLink = new Rectangle(0, 162*Luxe.camera.zoom, 70*Luxe.camera.zoom, 38*Luxe.camera.zoom);

        inline function create_screen()
        {
            screen = new Sprite({
                texture: Luxe.loadTexture('assets/screen_start.png'),
                pos: new Vector(600, 100),
                // size: new Vector(900,300),
                depth: 20
            });
            screen.texture.filter = FilterType.nearest;


        } //create_screen

        create_screen();
    }

    override function init() {


    } //init

    override function onenter<T>(_:T) 
    {
        trace('where is menu screen again?');
        timer = 0;
        canPlay = false;

        screen.color.a = 0;
        screen.pos.x = 600;

        Actuate.tween(screen.pos, 1, { x:150 })
            .ease( luxe.tween.easing.Quint.easeInOut );

        screen.color.tween(0.4, {a:1});
    }

    override function onleave<T>(_:T) {

        screen.color.tween(1, {a:0});

    }


    override function update( dt:Float ) {

        timer += dt;
        if(timer >= 2) {
            canPlay = true;
        }

    } //update

    override function onkeyup( e:KeyEvent ) {

            //escape from the menu state quits
        if(e.keycode == Key.space) {

            Main.state.set('game');
        }

    } //onkeyup


    override function onmousemove(e:MouseEvent) {

#if js
        if( twitterLink.point_inside( e.pos ) ){
            js.Browser.document.getElementById("window1").style.cursor = "pointer"; 
        }else{
            js.Browser.document.getElementById("window1").style.cursor = "auto"; 
        }
#end

    } //init

    override function onmousedown(e:MouseEvent) {

        if( twitterLink.point_inside( e.pos ) ){
            Luxe.io.url_open("https://twitter.com/Zielakpl");
        }

    } //init


}