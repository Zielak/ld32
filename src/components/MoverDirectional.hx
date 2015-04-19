package components;

import luxe.Vector;
import components.Mover;
import luxe.options.ComponentOptions;

class MoverDirectional extends Mover{

        // speeds
    public var moveSpeed:Float = 400;
    public var angle:Float = 0;
    var vel:Vector;

    var _speed:Float = 0;

    override public function new(_options:MoverDirectionalOptions)
    {
        super(_options);

        if(_options.moveSpeed != null){
            moveSpeed = _options.moveSpeed;
        }
        if(_options.angle != null){
            angle = _options.angle;
        }
        if(_options.velocity != null){
            vel = _options.velocity;
        }
    }

    override function init()
    {
        
    }

    override function onfixedupdate(dt:Float)
    {
        actor.velocity.set_xy(moveSpeed, 0);
        actor.velocity.angle2D = angle;
        // vel.multiplyScalar(0.3);
        // actor.velocity.add(vel);
    }

}

typedef MoverDirectionalOptions = {
    > ComponentOptions,

    var angle:Float;
    var moveSpeed:Float;
    @:optional var velocity:Vector;
}
