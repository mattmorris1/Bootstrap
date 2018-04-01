package agent.states 
{
	import agent.VillagerAgent;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class FleeStateV implements IAgentStateV
	{
		
		public function FleeStateV() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:VillagerAgent):void
		{
			if (a.numCycles < 10) return;
			//a.say("Help!");
			a.speed = 2;
			a.faceMouse( -1);
			if(a.numCycles>80){
				if (a.distanceToMouse > a.fleeRadius) {
				}
			}
		}
		
		public function enter(a:VillagerAgent):void
		{
			//a.say("Help!");
			a.faceMouse(1);
			a.speed = 0;
		}
		
		public function exit(a:VillagerAgent):void
		{
			
		}
		
	}

}