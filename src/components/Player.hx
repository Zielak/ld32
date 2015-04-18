package components;

import luxe.Component;
import luxe.components.sprite.SpriteAnimation;

class Player extends Component
{

    var anim:SpriteAnimation;
    var input:InputPlayer;
    
    override function init()
    {
        anim = get('anim');
        input = get('input');
    }


    override function onfixedupdate(dt:Float)
    {
        if(input==null){
            if(has('input')){
                input = get('input');
            }
        }
        if(anim==null){
            if(has('anim')){
                anim = get('anim');
            }
        }

        if(anim!=null && input!=null)
        {
            updateAnims();
        }
    }


    function updateAnims()
    {
        if(input.up){
            anim.animation = 'up';
        }
        if(input.down){
            anim.animation = 'down';
        }
        if(input.left){
            anim.animation = 'left';
        }
        if(input.right){
            anim.animation = 'right';
        }
    }
        
}
