package ;

import luxe.Entity;
import luxe.Rectangle;

class Director extends Entity
{
    
    static public var bounds:Rectangle;



    static public function init_director()
    {

        Luxe.camera.zoom = 3;
        Luxe.camera.pos.x = -Luxe.screen.w/Luxe.camera.zoom;
        Luxe.camera.pos.y = -Luxe.screen.h/Luxe.camera.zoom;

        bounds = new Rectangle(0,0,Luxe.screen.w/(Luxe.camera.zoom), Luxe.screen.h/(Luxe.camera.zoom));

        trace('bounds : ${bounds}');
        trace('Luxe.camera.pos : ${Luxe.camera.pos}');
    }

}