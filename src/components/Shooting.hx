package components;

import components.Bounds;
import components.InputPlayer;
import luxe.collision.shapes.Polygon;
import luxe.Color;
import luxe.Component;
import luxe.components.sprite.SpriteAnimation;
import luxe.Rectangle;
import luxe.resource.Resource;
import luxe.Sprite;
import luxe.utils.Maths;
import luxe.Vector;
import phoenix.Texture;

class Shooting extends Component
{
    var cooldown:Float = 0;
    var maxcooldown:Float = 0.5;


    var input:InputPlayer;
    var actor:Actor;

    var anim_object:JSONResource;

    override function init()
    {
        actor = cast entity;

        anim_object = Luxe.loadJSON('assets/soundwaveanim.json');

        input = get('input');

        cooldown = maxcooldown;
    }

    override function onfixedupdate(dt:Float)
    {
        if(input == null){
            if(has('input')){
                input = get('input');
            }
        }

        if(cooldown >= 0) cooldown -= dt;
        if(cooldown < 0 && input.a)
        {
            shootBullet();
            cooldown = maxcooldown;
        }
    }


    function shootBullet()
    {
        var _image:Texture;
        _image = Luxe.loadTexture('assets/notes.png');
        _image.filter = nearest;

        var bullet:Actor = new Actor({
            name: 'bullet',
            name_unique: true,
            pos: new Vector().copy_from(entity.pos),
            size: new Vector(16,16),
            // color: new Color().rgb(0xffffff),
            texture: _image,
        });
        bullet.geometry_quad.uv(new Rectangle(16* Maths.random_int(0,3) ,0,16,16));
        bullet.fixed_rate = 1/60;

        bullet.add(new components.MoverDirectional({
            name: 'mover',
            angle: input.mouseAngle,
            velocity: new Vector().copy_from(actor.velocity),
            moveSpeed: 200,
        }));
        bullet.add(new components.Collider({
            name: 'collider',
            shape: Polygon.rectangle(0, 0, 16,16, true),
            testAgainst: 'man',
            name_actor: 'bullet',
        }));

        bullet.add(new components.RemoveAfter({name: 'removeafter', time: 0.5}));
        

        // var anim = bullet.add( new SpriteAnimation({ name:'anim' }) );
        // anim.add_from_json_object( anim_object.json );
        // anim.animation = 'fly';
        // anim.play();

        // bullet.rotation_z = input.mouseAngle * 180 / Math.PI;
    }

}
