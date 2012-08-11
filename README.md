EEHUDView
=========================

EEHUDViewは非常に軽量で使いやすいiOS用のHUDです。  
EEHUDView is an easy-to-use, clean and lightweight HUD for iOS.  

![main image](https://lh5.googleusercontent.com/-D4prt2WDrv0/T902ENPr9OI/AAAAAAAAAPE/vfjaHdjztzA/s800/120617-0002.png)  

特徴 - Feature
-----------------  
* クラスメソッドを呼ぶ事でHUDを表示します (You can show HUD to call class method.)  

[demo - youtube](http://youtu.be/QcRMokpS_3E "growl")  

	[EEHUDView growlWithMessage:@"message"
       	              showStyle:EEHUDViewShowStyleFadeIn
           	          hideStyle:EEHUDViewHideStyleFadeOut
           	    resultViewStyle:EEHUDResultViewStyleChecked
           	           showTime:2.0];
    

* 2つの表示モードがあります (EEHUDView has two mode.)  
    * growl mode  
        * HUDを表示します(出て消える)  
    	```+ (void)growlWithMessage:showStyle:hideStyle:resultViewStyle:showTime:(float)time```  
    * progress mode  
    	* HUD – progress – を表示します。(出っぱなし) 
 		```+ (void)showProgressWithMessage:showStyle:activityViewStyle:```  
 		* HUD - progress - の進捗度を更新できます (0.0 - 1.0)  
		```+ (void)updateProgress:```  
		* HUD - progress - を非表示にします  
		```+ (void)hideProgressWithMessage:hideStyle:resultViewStyle:showTime:```  


注意 - Warning  
-------------------



