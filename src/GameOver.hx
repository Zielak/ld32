package ;

import luxe.Color;
import luxe.Input;
import luxe.Rectangle;
import luxe.tween.Actuate;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;
import luxe.Text;
import phoenix.Texture.FilterType;


class GameOver extends State {

    var screen:Sprite;

    var scoreText:Text;
    var deadText:Text;
    var timeText:Text;

    var twitterLink:Rectangle;

    public function new()
    {
        super({ name:'gameover' });

        twitterLink = new Rectangle(0, 167*Luxe.camera.zoom, 154*Luxe.camera.zoom, 33*Luxe.camera.zoom);

        inline function create_screen()
        {
            screen = new Sprite({
                texture: Luxe.loadTexture('assets/screen_over.png'),
                pos: new Vector(600, 100),
                depth: 20
            });
            screen.texture.filter = FilterType.nearest;


        } //create_screen

        create_screen();
    }

    override function init() {

        screen.color.a = 0;

    } //init

    override function onenter<T>(_:T) 
    {

        inline function create_text()
        {
            var _height:Int = 13;

            scoreText = new Text({
                bounds : new Rectangle(80, 77, 160, _height),
                point_size : 12,
                depth : 23.1,
                align : TextAlign.left,
                text : '${Main.score} people are dancing now!',
                color : new Color().rgb(0xFFFFFF),
            });

            deadText = new Text({
                bounds : new Rectangle(80, 77+_height, 160, _height),
                point_size : 12,
                depth : 23.2,
                align : TextAlign.left,
                text : '${Main.dead} people died of sadness.',
                color : new Color().rgb(0xFFFFFF),
            });

            timeText = new Text({
                bounds : new Rectangle(80, 77+_height*2, 160, _height),
                point_size : 12,
                depth : 23.3,
                align : TextAlign.left,
                text : '${Main.levels} levels in ${Math.floor(Main.playtime)} seconds!',
                color : new Color().rgb(0xFFFFFF),
            });
            
        }

        create_text();

        Luxe.renderer.clear_color.tween(0.2,{ r:0.0, g:0.0, b:0.0 });

        Actuate.tween(screen.pos, 1, { x:150 })
            .ease( luxe.tween.easing.Quint.easeInOut );

        screen.color.tween(0.4, {a:1});
    }

    override function onleave<T>(_:T) {

        screen.color.tween(1, {a:0});
        // Actuate.tween(screen.pos, 1, { y:300 })
        //     .ease( luxe.tween.easing.Quint.easeIn );

        scoreText.destroy();
        deadText.destroy();
        timeText.destroy();

        Main.levels = 0;
        Main.score = 0;
        Main.dead = 0;
        Main.playtime = 0;

    }


    override function onkeyup( e:KeyEvent ) {

            //escape from the menu state quits
        if(e.keycode == Key.space) {

            Main.state.set('logo');
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