package ane
{
	import flash.events.ErrorEvent;
	
	import pl.mateuszmackowiak.nativeANE.NativeDialogEvent;
	import pl.mateuszmackowiak.nativeANE.alert.NativeAlert;
	import pl.mateuszmackowiak.nativeANE.progress.NativeProgress;
	import pl.mateuszmackowiak.nativeANE.toast.Toast;

	public class ANEFunctions
	{
		private static var progressPopup:NativeProgress;
		public function ANEFunctions()
		{
		}
		
		public static function openProgressPopup(style:int, title:String, message:String, iosTheme:uint = 0x00000004, androidTheme:uint=0x00000005, cancelable:Boolean = false, indeterminate:Boolean = true):void
		{
			try
			{
				progressPopup = new NativeProgress(style);
				progressPopup.addEventListener(NativeDialogEvent.CANCELED,closeNativeProgressHandler);
				progressPopup.addEventListener(NativeDialogEvent.CLOSED,closeNativeProgressHandler);
				progressPopup.androidTheme = androidTheme;
				progressPopup.iosTheme = iosTheme;
				
				progressPopup.setTitle(title);
				progressPopup.setMessage(message);
				progressPopup.show(cancelable, indeterminate);
				
			}catch(e:Error)
			{
				trace("Error "+ e.message+"   "+e.toString());
			}
		}
		
		private static function closeNativeProgressHandler(event:NativeDialogEvent):void
		{
			trace(event.toString());
			
			progressPopup.removeEventListener(NativeDialogEvent.CANCELED,closeNativeProgressHandler);
			progressPopup.removeEventListener(NativeDialogEvent.CLOSED,closeNativeProgressHandler);
			progressPopup.dispose();
		}
		
		public static function closeProgressPopUp():void
		{
			if(progressPopup)
			{
				progressPopup.hide();
			}
		}
		
		public static function callAlert(title:String, message:String, otherButtonLables:String="", closeButtonLabel:String="OK", cancelable:Boolean=false, theme:uint=0x00000004):void
		{
			NativeAlert.show(message, title, closeButtonLabel, otherButtonLables, null, cancelable, theme);
		}
		
		public static function showToast(message:String, toastLength:int):void
		{
			Toast.show(message, toastLength);
		}
	}
}