package components;

import luxe.collision.data.ShapeCollision;
import luxe.Component;
import luxe.Entity;
import luxe.options.ComponentOptions;
import luxe.collision.shapes.Shape;
import luxe.Rectangle;

class Collider extends Component
{

    public var hit:Bool = false;
    public var shape:Shape;
    public var testAgainst:String;

    // sent to other component for recognition
    var name_actor:String;

    var _arr:Array<Entity>;
    var actor:Actor;
    var _a:Actor;
    var _c:Collider;
    var _s:Shape;

    var testArea:Rectangle;

    var data:ShapeCollision;

    override public function new(_options:ColliderOptions)
    {
        super(_options);

        shape = _options.shape;
        testAgainst = (_options.testAgainst!=null) ? _options.testAgainst : '';
        name_actor = _options.name_actor;
    }

    override function init()
    {
        testArea = new Rectangle(0,0,Game.bounds.w/8, Game.bounds.h/8);
        actor = cast entity;
        _arr = new Array<Entity>();
    }

    override function onremoved()
    {
        shape = null;
    }

    override function onfixedupdate(dt:Float)
    {
        if( actor.velocity.length > 0 ){
            shape.position.x = actor.realPos.x;
            shape.position.y = actor.realPos.y;

            if(testAgainst.length > 0)
            {
                testCollisions();
            }
        }
    }

    function testCollisions()
    {

        Luxe.scene.get_named_like(testAgainst, _arr);
        testArea.x = actor.realPos.x - testArea.w/2;
        testArea.y = actor.realPos.y - testArea.h/2;

        var testedCount:Int = 0;

        for(e in _arr)
        {
            // must be an actor
            _a = cast e;
            if(_a == null) continue;

            // must be nearby
            if(!testArea.point_inside(_a.realPos)) continue;

            testedCount ++;

            if(_a.has('collider'))
            {
                _c = cast actor.get('collider');
                _s = _c.shape;

                data = luxe.collision.Collision.shapeWithShape(shape, _s);

                if(data.overlap != 0){
                    _a.events.fire('collider.hit', {actor:actor, name_actor: name_actor});
                }
            }
        }

        // trace('so, I tested only: ${testedCount}');
    }

}

typedef ColliderOptions = {
    > ComponentOptions,

    var shape:Shape;
    var name_actor:String;
    @:optional var testAgainst:String;
}

typedef ColliderEvent = {
    var name_actor:String;
    var actor:Actor;
}
