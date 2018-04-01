package agent.states 
{
	import agent.warriorAgent;
	
	public interface IWarriorAgentState 
	{
		function update(a:warriorAgent):void;
		function enter(a:warriorAgent):void;
		function exit(a:warriorAgent):void;
	}
	
}