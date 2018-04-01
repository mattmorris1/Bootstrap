package agent.states 
{
	import agent.warriorAgent;
	public class AttackState implements IWarriorAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:warriorAgent):void
		{
			var dx:Number = a.C - a.x;
			var dy:Number = a.D - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
			if (a.numCycles < 40) return;
			//a.say("Attacking!");
			a.speed = 4;
			/*if (a.distanceToMouse > a.chaseRadius) {
				a.setState(Agent.CONFUSED);
			}*/
			/*if (a.distanceToMouse < a.fleeRadius) {
				a.setState(Agent.FLEE);
			}*/
		}
		
		public function enter(a:warriorAgent):void
		{
			var dx:Number = a.C - a.x;
			var dy:Number = a.D - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
		//	a.say("Oh wow! Something to chase!");
			a.speed = 0;
		}
		
		public function exit(a:warriorAgent):void
		{
			
		}
		
	}

}