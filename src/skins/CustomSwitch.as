package skins
{
	import spark.skins.mobile.ToggleSwitchSkin;
	
	public class CustomSwitch extends ToggleSwitchSkin
	{
		public function CustomSwitch()
		{
			super();
			selectedLabel = "Demo ON";
			unselectedLabel = "Demo OFF";
		}
	}
}