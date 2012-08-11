EEHUDView
=========================

EEHUDViewは非常に軽量で使いやすいiOS用のHUDです。  
EEHUDView is an easy-to-use, clean and lightweight HUD for iOS.  

![main image](https://lh5.googleusercontent.com/-D4prt2WDrv0/T902ENPr9OI/AAAAAAAAAPE/vfjaHdjztzA/s800/120617-0002.png)  

特徴 - Feature
-----------------  
* クラスメソッドを呼ぶ事でHUDを表示します (You can show HUD to call class method.)  

[demo - youtube](http://youtu.be/QcRMokpS_3E "growl")  

``` objective-c 
[EEHUDView growlWithMessage:@"message"
   	              showStyle:EEHUDViewShowStyleFadeIn
       	          hideStyle:EEHUDViewHideStyleFadeOut
       	    resultViewStyle:EEHUDResultViewStyleChecked
       	           showTime:2.0];
```      

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

[demo - youtube](http://youtu.be/bTrCc9xvzPE "progress")  

``` objective-c
- (void)buttonPressed:(id)sender {
  [EEHUDView showProgressWithMessage:@"message"
                           showStyle:EEHUDViewShowStyleFadeIn
                   activityViewStyle:EEHUDActivityViewStyleBeat];
  double delayInSeconds = 1.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                        target:self
                                                      selector:@selector(updateProgress:)
                                                      userInfo:nil
                                                       repeats:YES];
      [timer fire];
  });
}

- (void)updateProgress:(NSTimer *)timer
{
  if (_progress >= 1.0) {
      [timer invalidate];
      timer = nil;
      [EEHUDView hideProgressWithMessage:@"Finished"
                               hideStyle:EEHUDViewHideStyleToTop
                         resultViewStyle:EEHUDResultViewStyleChecked
                                showTime:1.5];
      _progress = 0.0;
  }
    
  [EEHUDView updateProgress:_progress];
  _progress += 0.01;
}
```

注意 - Warning  
-------------------
回転対応しました。  
EEHUDViewの回転は `EEHUDViewConstants.h` 内の以下定数により制御しております。  

`EEHUD_INTERFACE_ORIENTATION_PORTRAIT`  
`EEHUD_INTERFACE_ORIENTATION_LANDSCAPE_LEFT`  
`EEHUD_INTERFACE_ORIENTATION_LANDSCAPE_RIGHT`  
`EEHUD_INTERFACE_ORIENTATION_PORTRAIT_UPSIDEDOWN`  

![orientation](https://lh5.googleusercontent.com/-a3EKZnX5_Z0/T901FC4HHXI/AAAAAAAAAOw/5YLlz-_waJ4/s800/120617-0001.png)  

必ず、`EEHUDViewConstants.h`内にて所望の定数を定義してください。(You must set some constant to define orientation handling.)  
回転対応する方向をYESに対応しない方向をNOにしてください。  


定数 - Constants  
-------------------
* `EEHUDViewShowStyle`  
    * EEHUDViewShowStyleFadeIn  
    * EEHUDViewShowStyleLutz  
    * EEHUDViewShowStyleShake  
    * EEHUDViewShowStyleNoAnime  
    * EEHUDViewShowStyleFromRight  
    * EEHUDViewShowStyleFromLeft  
    * EEHUDViewShowStyleFromTop  
    * EEHUDViewShowStyleFromBottom  
    * EEHUDViewShowStyleFromZAxisNegative  
    * EEHUDViewShowStyleFromZAxisNegativeStrong  

* `EEHUDViewHideStyle`  
    * EEHUDViewHideStyleFadeOut  
    * EEHUDViewHideStyleLutz  
    * EEHUDViewHideStyleShake  
    * EEHUDViewHideStyleNoAnime  
    * EEHUDViewHideStyleToLeft  
    * EEHUDViewHideStyleToRight  
    * EEHUDViewHideStyleToBottom  
    * EEHUDViewHideStyleToTop  
    * EEHUDViewHideStyleCrush  
    * EEHUDViewHideStyleToZAxisNegative  
    * EEHUDViewHideStyleToZAxisNegativeStrong  

* `EEHUDResultViewStyle`  
  
| EEHUDResultViewStyleOK | EEHUDResultViewStyleNG | EEHUDResultViewStyleChecked |
|:------:|:------:|:------:|
![OK](https://lh6.googleusercontent.com/-D4TQoDbF60g/T6OIllIAN2I/AAAAAAAAALA/WjTrCnVsiWM/s800/001_OK.png)|![NG](https://lh5.googleusercontent.com/-lxzV7SXuv8g/T6OIlv0jVdI/AAAAAAAAAK8/RXd56F5JqAE/s800/002_NG.png)|![Check](https://lh6.googleusercontent.com/-aAVm3jgPHHQ/T6OIlnZoCzI/AAAAAAAAALM/YVM6CwynwuM/s800/003_Checked.png)|  
| EEHUDResultViewStyleUpArrow | EEHUDResultViewStyleDownArrow | EEHUDResultViewStyleRightArrow |
|:------:|:------:|:------:|



* `EEHUDActivityViewStyle`  



