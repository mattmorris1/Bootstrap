package agent.states 
{
	import agent.warriorAgent;
	public class SearchState implements IWarriorAgentState
	{
	
		public function update(a:warriorAgent):void
		{
			//a.say("Search");
			a.velocity.x += Math.random() * 0.2 - 0.1;
			a.velocity.y += Math.random() * 0.2 - 0.1;
			//if (a.numCycles > 120) {
			//	a.setState(Agent.IDLE);
			//}
			//if (!a.canSeeMouse) return;
			//if (a.distanceToMouse < a.fleeRadius) {
			//	a.setState(Agent.FLEE);
			if (a.distanceToMouse < a.chaseRadius) {
				a.setState(warriorAgent.ATTACK);
			}
		}
		
		public function enter(a:warriorAgent):void
		{
			a.speed = 1;
		}
		
		public function exit(a:warriorAgent):void
		{
			
		}
	}
}