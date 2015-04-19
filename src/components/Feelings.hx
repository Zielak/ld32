package components;

import components.Collider.ColliderEvent;
import luxe.Component;
import luxe.Rectangle;
import luxe.Sound;
import luxe.utils.Maths;
import luxe.components.sprite.SpriteAnimation;

class Feelings extends Component{

    public static inline var HAPPY_MIN:Float = 4;
    public static inline var HAPPY_MAX:Float = 15;
    public static inline var HAPPY_DANCING:Float = 20;

    public static inline var DEATH_FRAME1:Int = 20;
    public static inline var DEATH_FRAME4:Int = 23;


    public var happy:Float;
    public var dancing:Bool;
    public var dead:Bool;

    
    var anim:SpriteAnimation;
    var danceNames:Array<String>;

    var actor:Actor;
    var deadSound:Sound;
    var danceSound:Sound;


    override function init()
    {
        // trace('init');
        actor = cast entity;

        danceNames = ['dance1', 'dance2', 'dance3', 'dance4'];

        anim = get('anim');
        anim.animation = 'still';
        var _frame = Maths.random_int(0,3);
        actor.geometry_quad.uv(new Rectangle(16*_frame,0,16,16));

        if(_frame == 2){
            Luxe.timer.schedule(1, function(){
                var _mover:MoverWalking = cast get('walking');
                _mover.maxWalkSpeed = 1;
            });
        }

        happy = Maths.random_float(HAPPY_MIN, HAPPY_MAX);
        dancing = false;
        dead = false;


        entity.events.listen('collider.hit', function(e:ColliderEvent){
            if(e.name_actor == 'bullet' && !dancing){
                startDancing();
            }
        });


        // trace('init, loading sounds');
        Luxe.audio.on("dead", "load", function(e){
            deadSound = e;
            deadSound.volume = 0.45;
        });
        Luxe.audio.on("dance", "load", function(e){
            danceSound = e;
            danceSound.volume = 0.2;
        });
    }

    override function onremoved()
    {
        deadSound = null;
        danceSound = null;
    }

    override function onfixedupdate(dt:Float)
    {

        if(!dancing && !dead)
        {
            happy -= dt;

            if(happy <= 0){
                suicide();
            }
        }

        if(happy >= HAPPY_DANCING && !dancing)
        {
            startDancing();
        }

        

        if(anim==null){
            if(has('anim')){
                anim = get('anim');
            }
        }else{
            // updateAnims();
        }

    }

    function startDancing()
    {
        danceSound.play();
        danceSound.pitch = Maths.random_float(0.8,1.2);

        anim.animation = danceNames[Maths.random_int(0,danceNames.length-1)];
        anim.play();
        anim.frame = Maths.random_int(0,3);

        Luxe.events.fire('people.happy', this);
        actor.events.fire('startDancing');

        remove('collider');

        dancing = true;
    }


    function suicide()
    {
        deadSound.play();
        deadSound.pitch = Maths.random_float(0.8,1.2);

        dead = true;
        var _frame = Maths.random_int(0,3);
        actor.geometry_quad.uv(new Rectangle(16*_frame,5*16,16,16));

        // remove components
        remove('input');
        remove('controller');
        remove('collider');
        remove('walking');

        actor.velocity.set_xy(0,0);

        Luxe.events.fire('people.death', this);
        actor.events.fire('death');
    }

}
