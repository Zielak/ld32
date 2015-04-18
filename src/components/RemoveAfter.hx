package components;

import luxe.options.ComponentOptions;

class RemoveAfter extends luxe.Component
{

    var time:Float;
    
    override public function new(_options:RemoveAfterOptions)
    {
        super(_options);
        
        time = _options.time;
    }

    override function onfixedupdate(dt:Float)
    {
        trace('update()');
        time -= dt;

        if(time <= 0){
            entity.destroy(true);
            trace('destroy(true)');
        }
    }

}

typedef RemoveAfterOptions = {
    > ComponentOptions,

    var time:Float;
}
