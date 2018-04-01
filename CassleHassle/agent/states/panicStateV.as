package agent.states
{
	import agent.VillagerAgent;
	public class panicStateV implements IAgentStateV
	{
		
		public function update(a:VillagerAgent):void
		{
			//a.say("RUN.!!");
			a.velocity.x += Math.random() * 0.2 - 0.1;
			a.velocity.y += Math.random() * 0.2 - 0.1;
			if (a.numCycles > 120) {
			}
			//if (!a.canSeeMouse) return;
			if (a.distanceToMouse < a.fleeRadius) {
				a.setState(VillagerAgent.FLEE);
			}/*else if (a.distanceToMouse < a.chaseRadius) {
				a.setState(Agent.CHASE);
			}*/
		}
		
		public function enter(a:VillagerAgent):void
		{
			a.speed = 3;
		}
		
		public function exit(a:VillagerAgent):void
		{
			
		}
	}
}