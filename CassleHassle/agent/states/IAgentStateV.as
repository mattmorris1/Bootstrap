package agent.states
{
	import agent.VillagerAgent;
	
	public interface IAgentStateV
	{
		function update(a:VillagerAgent):void;
		function enter(a:VillagerAgent):void;
		function exit(a:VillagerAgent):void;
	}
	
}