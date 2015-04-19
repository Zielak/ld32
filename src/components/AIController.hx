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


    var seqSad:Sequence;
    var seqDance:Sequence;


    override function init()
    {
        m_tree = new BehaviorTree();

        seqSad = new Sequence();
        seqSad.add(new behaviors.Wait({time: 3, randomizeTime: 2}));
        seqSad.add(new behaviors.MoveInRandomDirection({time: 1, randomizeTime: 1}));

        seqDance = new Sequence();
        seqDance.add(new behaviors.MoveInRandomDirection({time: 1, randomizeTime: 0}));

        m_tree.set(seqSad, {actor: cast(entity, Actor)});

        mover = cast get('mover');


        entity.events.listen('startDancing', function(_){
            if( !get('feelings').dancing )
            {
                m_tree = new BehaviorTree();
                m_tree.set(seqDance, {actor: cast(entity, Actor)});
            }
        });
    }

    override function onremoved()
    {
        m_tree = null;
        mover = null;
        seqSad = null;
        seqDance = null;
    }

    override function update(dt : Float)
    {
        m_tree.update(dt);
    }

}
