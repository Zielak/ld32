
package ;

import luxe.Visual;
import luxe.Color;
import luxe.Vector;
// import components.Mover;

class Actor extends Visual
{

    public var velocity         :Vector;
    public var speed(get, set)  :Float;
    public var realPos          :Vector;

    override function init():Void
    {
        velocity        = new Vector();

        realPos = new Vector();
        realPos.copy_from(pos);
    }

    override function ondestroy():Void
    {
        realPos = null;
        velocity = null;
    }

    override function update(dt:Float):Void
    {
        pos.copy_from(realPos);

        pos.x = Math.round(pos.x);
        pos.y = Math.round(pos.y);
        pos.z = Math.round(pos.z);
    }


    public function onfixedupdate(dt:Float)
    {
        if( Math.abs(velocity.x) < 0.1 && velocity.x!= 0 ) velocity.x = 0;
        if( Math.abs(velocity.y) < 0.1 && velocity.y!= 0 ) velocity.y = 0;

        realPos.x += velocity.x * dt;
        realPos.y += velocity.y * dt;
    }



    public function get_speed():Float
    {
        return velocity.get_length2D();
    }
    public function set_speed(v:Float):Float
    {
        velocity.set_length2D(v);
        return velocity.get_length2D();
    }

}
