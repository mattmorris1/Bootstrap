package agent.states 
{
	import agent.DragonAgent;
	import agent.VillagerAgent;
	import DragonMain;
	public class DragonChaseState implements IDragonAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(dragon:DragonAgent):void
		{
			var dx:Number = dragon.G - dragon.x;
			var dy:Number = dragon.H - dragon.y;
			var rad:Number = Math.atan2(dy, dx);
			dragon.velocity.x = Math.cos(rad);
			dragon.velocity.y = Math.sin(rad);
			if (dragon.numCycles < 40) return;
			//dragon.say("Chasing!");
			dragon.speed = 4;
			//if (dragon.distanceToA > dragon.chaseRadius) {
			//	dragon.setState(DragonAgent.CONFUSED);
			//}
			//if (dragon.distanceToA < dragon.fleeRadius) {
			//	dragon.setState(DragonAgent.FLEE);
			//}
		}
		
		public function enter(dragon:DragonAgent):void
		{
			var dx:Number = dragon.G - dragon.x;
			var dy:Number = dragon.H - dragon.y;
			var rad:Number = Math.atan2(dy, dx);
			dragon.velocity.x = Math.cos(rad);
			dragon.velocity.y = Math.sin(rad);
			//dragon.say("Oh wow! Something to chase!");
			dragon.speed = 0;
		}
		
		public function exit(dragon:DragonAgent):void
		{
			
		}
		
	}

}