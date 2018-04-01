package agent.states 
{
	import agent.DragonAgent;
	import DragonMain;
	import agent.VillagerAgent;
	public class DragonIdleState implements IDragonAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(dragon:DragonAgent):void
		{
			if (dragon.numCycles > 30) {
				dragon.setState(DragonAgent.CHASE);
			}
		}
		
		public function enter(dragon:DragonAgent):void
		{
			//dragon.say("Idling...");
			dragon.speed = 0;
		}
		
		public function exit(dragon:DragonAgent):void
		{
			dragon.randomDirection();
		}
		
	}

}