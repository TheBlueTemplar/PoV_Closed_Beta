if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.FleshGolems <-
{
	Name = "FleshGolems",
	IsDynamic = true,
	MovementSpeedMult = 0.7,
	VisibilityMult = 1.0,
	VisionMult = 0.7,
	Body = "pov_figure_fault_finder_01",
	MaxR = 600,
	MinR = 60,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.FaultFinder,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			Weight = 0,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.LesserFleshGolem,
					MaxR = 200,
					Cost = 10,
					function Weight(scale) {
						local c = 100 - (scale * 100);
						return this.Math.max(0, c);
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.GreaterFleshGolem,
					MaxR = 200,
					Cost = 40,
					function Weight(scale) {
						local c = 100 - (scale * 100);
						return this.Math.max(0, c);
					}
				}
			]
		}
	],
	Troops = [
		{
			Weight = 80,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LesserFleshGolem,
					Cost = 14
				}

			]
		},
		{
			Weight = 20,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GreaterFleshGolem, 
					Cost = 40
				}
			]
		}
	]
}