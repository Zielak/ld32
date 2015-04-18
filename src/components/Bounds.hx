package components;

import components.Mover;
import luxe.Rectangle;

class Bounds extends Mover{


    public var bounds:Rectangle;

    override function init()
    {
        bounds = new Rectangle(0, 0, Director.bounds.w, Director.bounds.h);
    }

    override function onfixedupdate(dt:Float)
    {
        if(actor.realPos.x < bounds.x){
            trace('bounds - left');
            actor.realPos.x = bounds.x;
        }else if(actor.realPos.x > bounds.x+bounds.w){
            trace('bounds - right');
            actor.realPos.x = bounds.x+bounds.w;
        }

        if(actor.realPos.y < bounds.y){
            trace('bounds - top');
            actor.realPos.y = bounds.y;
        }else if(actor.realPos.y > bounds.y+bounds.h){
            trace('bounds - bottom');
            actor.realPos.y = bounds.y+bounds.h;
        }
    }

}
