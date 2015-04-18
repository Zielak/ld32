package components;

import components.InputAI;
import hxbt.BehaviorTree;
import hxbt.Sequence;
import components.Mover;
import luxe.Component;

class AIController extends Component
{

    var m_tree:BehaviorTree;

    var mover:Mover;


    override function init()
    {
        m_tree = new BehaviorTree();

        var seq = new Sequence();
        seq.add(new behaviors.MoveInRandomDirection({time: 1, randomizeTime: 2}));
        seq.add(new behaviors.Wait({time: 2, randomizeTime: 1}));

        m_tree.set(seq, {actor: cast(entity, Actor)});


        mover = cast get('mover');
    }

    override function update(dt : Float)
    {
        m_tree.update(dt);
    }

}
