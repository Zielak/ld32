package ;

import luxe.Entity;
import luxe.Input;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import luxe.Visual;

import phoenix.Batcher;
import phoenix.Camera;
import luxe.Color;


class HUD extends Entity
{

    @:isVar public var hud_batcher(default, null):Batcher;

    var scoreText:Text;
    var timeText:Text;
    var deadText:Text;

    override public function init():Void
    {
        hud_batcher = Luxe.renderer.create_batcher({
            name : 'hud_batcher',
            layer : 10,
            // no_add : true,
        });


        setupEvents();
        setupHUD();
    }

    function setupEvents()
    {

        // Luxe.events.listen('director.score', function(e:TextEvent){
        //     textFieldString = e.s+"\n";
        // });
        // Luxe.events.listen('director.time', function(e:TextEvent){
        //     textFieldString += e.s+"\n";
        // });
        // Luxe.events.listen('director.dead', function(e:TextEvent){
        //     textFieldString += e.s+"\n";
        // });


    }



    function setupHUD()
    {
        Luxe.draw.box({
            x: 0, y: 0,
            w: Luxe.screen.w, h: 36,
            color: new Color(0.27, 0.18, 0.64, 0.85),
            batcher: hud_batcher,
        });

        Luxe.draw.box({
            x: 16, y: 16,
            w: 16, h: 16,
            color: new Color(0.27, 0.18, 0.64, 0.85),
            batcher: hud_batcher,
        });
        scoreText = new Text({
            bounds : new Rectangle(16,16,Luxe.screen.w/3, 32),
            point_size : 16,
            depth : 3.1,
            align : TextAlign.left,
            text : '0',
            color : new Color().rgb(0xFFFFFF),
            batcher : hud_batcher
        });

        timeText = new Text({
            bounds : new Rectangle(Luxe.screen.w/4,16,Luxe.screen.w/2, 32),
            point_size : 16,
            depth : 3.2,
            align : TextAlign.center,
            text : '0:00',
            color : new Color().rgb(0xFFFFFF),
            batcher : hud_batcher
        });

        deadText = new Text({
            bounds : new Rectangle(Luxe.screen.w/3*2,16,Luxe.screen.w/3-16, 32),
            point_size : 16,
            depth : 3.3,
            align : TextAlign.right,
            text : '0',
            color : new Color().rgb(0xFFFFFF),
            batcher : hud_batcher
        });

        // Luxe.debug.batcher = hud_batcher;

    }



    override function update(dt:Float):Void
    {


    }

}