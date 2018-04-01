package agent.states 
{
	import agent.DragonAgent;
	import DragonMain;
	import agent.VillagerAgent;
	public class DragonWanderState implements IDragonAgentState
	{
		
		public function update(dragon:DragonAgent):void
		{
			//dragon.say("Wandering...");
			dragon.velocity.x += Math.random() * 0.2 - 0.1;
			dragon.velocity.y += Math.random() * 0.2 - 0.1;
			if (dragon.numCycles > 120) {
				dragon.setState(DragonAgent.IDLE);
			}
			if (!dragon.canSeeA) return;
			//if (dragon.distanceToA < dragon.fleeRadius) {
			//	dragon.setState(DragonAgent.FLEE);}
			else if (dragon.distanceToA < dragon.chaseRadius) {
				dragon.setState(DragonAgent.CHASE);
			}
		}
		
		public function enter(dragon:DragonAgent):void
		{
			dragon.speed = 1;
		}
		
		public function exit(dragon:DragonAgent):void
		{
			
		}
	}
}