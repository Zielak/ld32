
package components;

import luxe.Input;
import luxe.Vector;
import luxe.Component;

class InputPlayer extends Component
{


    @:isVar public var up       (default, null):Bool;
    @:isVar public var down     (default, null):Bool;
    @:isVar public var left     (default, null):Bool;
    @:isVar public var right    (default, null):Bool;

    @:isVar public var dir      (default, null):Int;

    @:isVar public var a        (default, null):Bool;
    @:isVar public var b        (default, null):Bool;

    @:isVar public var angle        (default, null):Float;
    @:isVar public var mouseAngle   (default, null):Float;

    @:isVar public var movePressed  (default, null):Bool;

    var screen_mouse:Vector;
    var world_mouse:Vector;
    var view_mouse:Vector;
    var _vec:Vector;

    override function init():Void
    {
        angle = 0;
        mouseAngle = 0;

        screen_mouse = new Vector();
        world_mouse = new Vector();
        view_mouse = new Vector();
        _vec = new Vector();

        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('right', Key.key_d);

        Luxe.input.bind_mouse('a', MouseButton.left);
        Luxe.input.bind_mouse('b', MouseButton.right);
    }

    override function onfixedupdate(dt:Float):Void
    {
        updateKeys();
    }


    function updateKeys():Void
    {
        up    = Luxe.input.inputdown('up');
        down  = Luxe.input.inputdown('down');
        left  = Luxe.input.inputdown('left');
        right = Luxe.input.inputdown('right');

        a     = Luxe.input.inputdown('a');
        b     = Luxe.input.inputdown('b');

        if( up && down )
        {
            up = down = false;
        }
        if( left && right )
        {
            left = right = false;
        }

        movePressed = false;


        if( up || down || left || right )
        {
            movePressed = true;

            if ( up )
            {
                angle = Math.PI*3 / 2;//-90;
                if ( left )
                    angle -= Math.PI/4;
                else if ( right )
                    angle += Math.PI/4;
            }
            else if ( down )
            {
                angle = Math.PI/2;//90;
                if ( left )
                    angle += Math.PI/4;
                else if ( right )
                    angle -= Math.PI/4;
            }
            else if ( left )
                angle = Math.PI;
            else if ( right )
                angle = 0;
        }
    }

    function updateMouse()
    {
        
    }


    override function onmousemove( e:MouseEvent )
    {
        // trace('moved');

        screen_mouse = e.pos;
        // trace('screen_mouse: ${screen_mouse}');
        world_mouse = Luxe.camera.screen_point_to_world( e.pos );
        // trace('world_mouse: ${world_mouse}');

        _vec = Vector.Subtract(world_mouse, entity.pos);
        mouseAngle = _vec.angle2D;
        // trace('mouseAngle: ${mouseAngle}');
        // trace('=====================================================');

    }

}
