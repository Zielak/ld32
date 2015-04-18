package hxbt.loaders;
import hxbt.BehaviorTree;

/**
 * The BehaviorTreeJSONLoader loads a behavior from a JSON file
 * with a very simple structure.
 * The structure of the behavior tree JSON is the following:

	{
		"tree_name" : 
		[
			"hxbt.selector" : 
			[
				"hxbt.sequence" : 
				[
					"package.behavior0" : [],
					"package.behavior1" : []
				],
				"hxbt.sequence" : 
				[
					"package.behavior2" : [],
					"package.behavior3" : []
				]
			]
		]
	}
	 
 * @author Kristian Brodal
 */
class BehaviorTreeJSONLoader
{

	private function new() 
	{
		
	}
	
	//	Constructs the behavior tree 'treeName' defined in the JSON file 'JSON'.
	//	Returns constructed tree if successful, returns null if unsuccessful.
	public static function FromJSONString(JSON : String, treeName : String) : BehaviorTree
	{
		return null;
	}
	
	//	Constructs the behavior tree 'treeName' defined in the JSON file 'JSON'.
	//	Returns constructed tree if successful, returns null if unsuccessful.
	public static function FromJSONObject(JSON : Dynamic, treeName : String) : BehaviorTree
	{
		return null;
	}
}