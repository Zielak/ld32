package ;

import luxe.Entity;
import luxe.Input;
import luxe.Rectangle;
import luxe.Sprite;
import luxe.Text;
import luxe.Vector;
import luxe.Visual;

import phoenix.Batcher;
import phoenix.Camera;
import luxe.Color;
import phoenix.Texture;


class HUD extends Entity
{

    @:isVar public var hud_batcher(default, null):Batcher;

    var scoreText:Text;
    var timeText:Text;
    var deadText:Text;

    var iconImage:Texture;

    override public function init():Void
    {
        trace('HUD init');

        hud_batcher = Luxe.renderer.create_batcher({
            name : 'hud_batcher',
            layer : 10,
            // no_add : true,
        });

        iconImage = Luxe.loadTexture('assets/icons.png');
        iconImage.filter = nearest;
        
        setupHUD();

        setupEvents();
    }

    override function ondestroy()
    {
        hud_batcher.empty(true);
    }

    function setupEvents()
    {
        Luxe.events.listen('game.happy.text', function(_){
            // scoreText.text = Std.string(Game.happyCount);
            scoreText.text = Std.string(Main.score);
        });
        Luxe.events.listen('game.time.text', function(e){
            timeText.text = e;
        });
        Luxe.events.listen('game.dead.text', function(_){
            // deadText.text = Std.string(Game.deadCount);
            deadText.text = Std.string(Main.dead);
        });
    }

    function setupHUD()
    {
        // background
        Luxe.draw.box({
            x: 0, y: 0,
            w: Luxe.screen.w, h: 64,
            color: new Color(0.27, 0.18, 0.64, 0.3),
            batcher: hud_batcher,
        });

        // Time
        var timeicon = Luxe.draw.box({
            x: Luxe.screen.w/2 - 16*Luxe.camera.zoom/2, y: 32,
            w: 16*Luxe.camera.zoom, h: 16*Luxe.camera.zoom,
            texture: iconImage,
            batcher: hud_batcher,
        });
        timeicon.uv(new Rectangle(32,0,16,16));

        timeText = new Text({
            bounds : new Rectangle(0, Luxe.screen.w/4, Luxe.screen.w, Luxe.screen.h),
            point_size : 150,
            depth : 3.2,
            align : TextAlign.center,
            text : '0:00',
            color : new Color(1,1,1,0.2),
            batcher : hud_batcher
        });


        // Score
        var scoreicon = Luxe.draw.box({
            x: Luxe.screen.w/3 + 16, y: 8,
            w: 16*Luxe.camera.zoom, h: 16*Luxe.camera.zoom,
            texture: iconImage,
            batcher: hud_batcher,
        });
        scoreicon.uv(new Rectangle(0,0,16,16));

        scoreText = new Text({
            bounds : new Rectangle(0, 8, Luxe.screen.w/3, 48),
            point_size : 44,
            depth : 3.1,
            align : TextAlign.right,
            text : '0',
            color : new Color().rgb(0xFFFFFF),
            batcher : hud_batcher,
        });

        // Dead
        var deadicon = Luxe.draw.box({
            x: Luxe.screen.w/3*2 - 16*Luxe.camera.zoom - 16, y: 8,
            w: 16*Luxe.camera.zoom, h: 16*Luxe.camera.zoom,
            texture: iconImage,
            batcher: hud_batcher,
        });
        deadicon.uv(new Rectangle(16,0,16,16));

        deadText = new Text({
            bounds : new Rectangle(Luxe.screen.w/3*2, 8, Luxe.screen.w/3, 48),
            point_size : 44,
            depth : 3.3,
            align : TextAlign.left,
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