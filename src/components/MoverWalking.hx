package components;

import components.Mover;

class MoverWalking extends Mover{

    
        // speeds
    var maxWalkSpeed:Float = 70;
    var accel_rate:Float = 5;
    var decel_rate:Float = 15;

    var _speed:Float = 0;
    var _angle:Float = 0;


    override function onfixedframe(dt:Float)
    {
        
    }
}
