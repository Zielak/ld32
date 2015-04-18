
package ;

import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.Vector;
// import components.Mover;

class Actor extends Sprite
{

    public var velocity         :Vector;
    public var speed(get, set)  :Float;
    public var realPos          :Vector;

    override function init():Void
    {
        fixed_rate = 1/60;

        velocity = new Vector();

        realPos = new Vector();
        realPos.copy_from(pos);
    }

    override function ondestroy():Void
    {
        realPos = null;
        velocity = null;
    }

    override function onfixedupdate(dt:Float)
    {
        // trace(realPos);
        pos.copy_from(realPos);

        pos.x = Math.round(pos.x);
        pos.y = Math.round(pos.y);

        if( Math.abs(velocity.x) < 0.1 && velocity.x!= 0 ) velocity.x = 0;
        if( Math.abs(velocity.y) < 0.1 && velocity.y!= 0 ) velocity.y = 0;


        realPos.x += velocity.x * dt;
        realPos.y += velocity.y * dt;
        
        this.depth = realPos.y;
    }



    public function get_speed():Float
    {
        return velocity.length;
    }
    public function set_speed(v:Float):Float
    {
        velocity.length = v;
        return velocity.length;
    }

}
