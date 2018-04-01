package agent.states 
{
	import agent.DragonAgent;
	import DragonMain;
	import agent.VillagerAgent;
	
	public interface IDragonAgentState 
	{
		function update(dragon:DragonAgent):void;
		function enter(dragon:DragonAgent):void;
		function exit(dragon:DragonAgent):void;
	}
	
}