package components;

import luxe.Component;
import luxe.Rectangle;

class Bounds extends Component{


    public var bounds           :Rectangle;

    override function init()
    {
        bounds = new Rectangle(0,0,Luxe.screen.w,Luxe.screen.h);

    }

    override function onfixedupdate(dt:Float)
    {
        if(entity.pos.x < bounds.x){
            entity.pos.x = bounds.x;
        }else if(entity.pos.x > bounds.x+bounds.w){
            entity.pos.x = bounds.x+bounds.w;
        }

        if(entity.pos.y < bounds.y){
            entity.pos.y = bounds.y;
        }else if(entity.pos.y > bounds.y+bounds.h){
            entity.pos.y = bounds.y+bounds.h;
        }
    }

}
