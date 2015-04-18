package components;

import luxe.Component;
import luxe.options.ComponentOptions;

class Collider extends Component
{

    public var hit:Bool = false;
    public var shape:Shape;

}

typedef ColliderOptions = {
    > ComponentOptions,

    var shape:Shape;
}
