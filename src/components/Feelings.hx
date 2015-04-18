package components;

import luxe.Component;
import luxe.Rectangle;
import luxe.utils.Maths;
import luxe.components.sprite.SpriteAnimation;

class Feelings extends Component{

    public static inline var HAPPY_MIN:Float = 1;
    public static inline var HAPPY_MAX:Float = 20;

    public static inline var DEATH_FRAME1:Int = 20;
    public static inline var DEATH_FRAME4:Int = 23;


    public var happy:Float;
    public var dancing:Bool;
    public var dead:Bool;

    
    var anim:SpriteAnimation;
    var danceNames:Array<String>;

    override function init()
    {
        danceNames = ['dance1', 'dance2', 'dance3', 'dance4'];

        anim = get('anim');
        anim.animation = 'still';
        anim.play();
        anim.set_frame( Maths.random_int(1,4) );
        anim.stop();

        happy = Maths.random_float(HAPPY_MIN, HAPPY_MAX);
        dancing = false;
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

        

        if(anim==null){
            if(has('anim')){
                anim = get('anim');
            }
        }else{
            // updateAnims();
        }

    }


    function suicide()
    {
        Luxe.events.fire('people.death', this);

        dead = true;

        // anim.animation = 'dead';
        // anim.play();

        anim.stop();
        anim.animation = 'dead';
        anim.frame = Maths.random_int(1, 4);
        // anim.set_frame(Maths.random_int(1, 4));
    }

}
