package components;

import luxe.Component;

class Mover extends Component{

    var actor:Actor;

    override function onadded()
    {
        actor = cast entity;
        if(actor==null) throw 'ONLY ON ACTORS, DUDE';
    }

    override function onremoved()
    {
        actor = null;
    }

}
