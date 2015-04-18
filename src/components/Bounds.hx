package components;

import components.Mover;
import luxe.options.ComponentOptions;
import luxe.Rectangle;

class Bounds extends Mover{


    var bounds:Rectangle;

    var killOnTouch:Bool = false;
    var _touched:Bool = false;

    override public function new(_options:BoundsOptions)
    {
        super(_options);

        if(_options.killOnTouch != null){
            killOnTouch = _options.killOnTouch;
        }

        if(_options.bounds != null){
            bounds = _options.bounds;
        }else{
            bounds = new Rectangle(0, 0, Director.bounds.w, Director.bounds.h);
        }
    }

    override function init()
    {

    }

    override function onfixedupdate(dt:Float)
    {
        if(actor.realPos.x < bounds.x + actor.size.x)
        {
            actor.realPos.x = bounds.x + actor.size.x;
            _touched = true;
        }
        else if(actor.realPos.x > bounds.x+bounds.w - actor.size.x)
        {
            actor.realPos.x = bounds.x+bounds.w - actor.size.x;
            _touched = true;
        }

        if(actor.realPos.y < bounds.y + actor.size.y)
        {
            actor.realPos.y = bounds.y + actor.size.y;
            _touched = true;
        }
        else if(actor.realPos.y > bounds.y+bounds.h - actor.size.y)
        {
            actor.realPos.y = bounds.y+bounds.h - actor.size.y;
            _touched = true;
        }

        if(_touched && killOnTouch){
            trace('tryign to remove myself');
            entity.destroy();

        }
    }

}

typedef BoundsOptions = {
    > ComponentOptions,

    @:optional var bounds:Rectangle;
    @:optional var killOnTouch:Bool;
}
