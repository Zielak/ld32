package ;

import luxe.tween.Actuate;
import luxe.Sprite;
import luxe.States;
import luxe.Input;
import luxe.Vector;
import phoenix.Texture.FilterType;


class Madewith extends State {

    var screen:Sprite;
    var timer:Float;

    public function new()
    {
        super({ name:'madewith' });

        inline function create_screen()
        {
            screen = new Sprite({
                texture: Luxe.loadTexture('assets/screen_luxe.png'),
                pos: new Vector(-300, 100),
                // size: new Vector(900,600),
                depth: 1
            });
            screen.texture.filter = FilterType.nearest;


        } //create_screen

        create_screen();
    }

    override function onmousedown(e:MouseEvent) {

        Luxe.io.url_open("http://luxeengine.com/");

    } //init

    override function onenter<T>(_:T) 
    {
        timer = 0;
        screen.color.a = 0;
        screen.pos.x = -300;

        Luxe.renderer.clear_color.tween(0.2,{ r:0.0, g:0.0, b:0.0 });

        Actuate.tween(screen.pos, 1, { x:150 })
            .ease( luxe.tween.easing.Quint.easeInOut );

        screen.color.tween(0.4, {a:1});
    }

    override function onleave<T>(_:T) {

        screen.color.tween(0.4, {a:0});

    }


    override function update( dt:Float ) {

        timer += dt;
        if(timer >= 2) {
            Main.state.set('menu');
        }

    } //update

}