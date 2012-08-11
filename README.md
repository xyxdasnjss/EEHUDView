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
  
||||
|:------:|:------:|:------:|
| EEHUDResultViewStyleOK | EEHUDResultViewStyleNG | EEHUDResultViewStyleChecked |
| ![OK image][ok] | ![NG image][ng] | ![Check image][check] |
| EEHUDResultViewStyleUpArrow | EEHUDResultViewStyleDownArrow | EEHUDResultViewStyleRightArrow |
| ![Up Arrow][up_arrow] | ![Down Arrow][down_arrow] | ![Right Arrow][right_arrow] |
| EEHUDResultViewStyleLeftArrow | EEHUDResultViewStylePlay | EEHUDResultViewStylePause|
| ![Right Arrow][right_arrow] | ![Play][play] | ![Pause][pause] |
| EEHUDResultViewStyleZero | EEHUDResultViewStyleOne | EEHUDResultViewStyleTwo |
| ![Zero][zero] |![One][one] |![Two][two] |
| EEHUDResultViewStyleThree | EEHUDResultViewStyleFour | EEHUDResultViewStyleFive |
| ![Three][three] | ![Four][four] | ![Five][five] |
| EEHUDResultViewStyleSix | EEHUDResultViewStyleSeven | EEHUDResultViewStyleEight |
| ![Six][six] | ![Seven][seven] | ![Eight][eight] |
| EEHUDResultViewStyleNine | EEHUDResultViewStyleExclamation | EEHUDResultViewStyleCloud |
| ![Nine][nine] | ![Exclamatino][exclamation] | ![Cloud][cloud] |
| EEHUDResultViewStyleCloudUp | EEHUDResultViewStyleCloudDown | EEHUDResultViewStyleMail |
| ![Cloud UP][cloud_up] | ![Cloud DOWN][cloud_down] | ![Mail][mail] |
| EEHUDResultViewStyleMicrophone | EEHUDResultViewStyleLocation | EEHUDResultViewStyleHome |
| ![Microphone][microphone] | ![Location][location] | ![Home][home] |
| EEHUDResultViewStyleTweet | EEHUDResultViewStyleClock | EEHUDResultViewStyleWifiFull |
| ![Tweet][tweet] | ![Clock][clock] | ![Wifi Full][wifi_full] |
| EEHUDResultViewStyleWifiEmpty |||
| ![Wifi Empty][wifi_empty] |||

* `EEHUDActivityViewStyle`  





[ok]: https://lh6.googleusercontent.com/-D4TQoDbF60g/T6OIllIAN2I/AAAAAAAAALA/WjTrCnVsiWM/s800/001_OK.png "OK icon"  
[ng]: https://lh5.googleusercontent.com/-lxzV7SXuv8g/T6OIlv0jVdI/AAAAAAAAAK8/RXd56F5JqAE/s800/002_NG.png "NG icon"  
[check]: https://lh6.googleusercontent.com/-aAVm3jgPHHQ/T6OIlnZoCzI/AAAAAAAAALM/YVM6CwynwuM/s800/003_Checked.png "Check icon"  
[up_arrow]: https://lh4.googleusercontent.com/-iCXoYP753KY/T6OImLcYgqI/AAAAAAAAALE/8genv0PcDRk/s800/004_UpArrow.png "Up Arrow icon"  
[down_arrow]: https://lh5.googleusercontent.com/-F9HMjYUACjw/T6OIsXkIzNI/AAAAAAAAAL8/qt13-lCnDiM/s800/005_DownArrow.png "Down Arrow icon"  
[right_arrow]: https://lh3.googleusercontent.com/-2TAnHqO4YKM/T6OIrNlHVII/AAAAAAAAAL0/T7sbDEJ-UB4/s800/006_RightArrow.png "Right Arrow icon"  
[left_arrow]: https://lh6.googleusercontent.com/-rWdNEMvtEVY/T6OInfCtj2I/AAAAAAAAALc/cLXpt5e3Ghc/s800/007_LeftArrow.png "Left Arrow icon"  
[play]: https://lh5.googleusercontent.com/-lEE_3lhjCp0/T6OIo09ySiI/AAAAAAAAALg/6XssC5BwdsI/s800/008_Play.png "Play icon"  
[pause]: https://lh4.googleusercontent.com/-pFqcFsTxyZI/T6OIoydhuPI/AAAAAAAAALk/NJcqUJ3AuIA/s800/009_Pause.png "Pause icon"  
[zero]: https://lh5.googleusercontent.com/-hWuJEOrTtgM/T6OYqfRkc7I/AAAAAAAAAMI/OUjLYEcCjss/s800/010_0.png "Zero icon"  
[one]: https://lh4.googleusercontent.com/-U4cA8zK6k8E/T6OYqSJfBnI/AAAAAAAAAMM/d1FnfpP_oCE/s800/011_1.png "One icon"  
[two]: https://lh3.googleusercontent.com/-BaqIvT8qUNA/T6OYvnjpNrI/AAAAAAAAAM0/27PdpA7d1Sk/s800/012_2.png "Two icon"  
[three]: https://lh6.googleusercontent.com/-ectWmpyW78Y/T6OYqz-30VI/AAAAAAAAAMQ/L2pbkD_4pVM/s800/013_3.png "Three icon"  
[four]: https://lh4.googleusercontent.com/-gtxf0m7gdBQ/T6OYrAl8-zI/AAAAAAAAAMU/KaGg7WmNGXk/s800/014_4.png "Four icon"
[five]: https://lh4.googleusercontent.com/-dKxQQfmiVBU/T6OYwijezQI/AAAAAAAAAM8/zeTCf2oaIMU/s800/015_5.png "Five icon"  
[six]: https://lh6.googleusercontent.com/-ZmvDSK-y9fw/T6OYrzM_vDI/AAAAAAAAAMk/tfBNY0Tz6qY/s800/016_6.png "Six icon"  
[seven]: https://lh6.googleusercontent.com/-orIuTdbAQ-o/T6OYxqToEZI/AAAAAAAAANI/2FjC3jSfOno/s800/017_7.png "Seven icon"  
[eight]: https://lh5.googleusercontent.com/-MXW5mcuSE0M/T6OYy62mgVI/AAAAAAAAANQ/N5Ot8-M40SY/s800/018_8.png "Eight icon"  
[nine]: https://lh3.googleusercontent.com/-jmho3WMMa6Q/T6OYtexGRKI/AAAAAAAAAMw/pNQaGENsj48/s800/019_9.png "Nine icon"  
[exclamation]: https://lh5.googleusercontent.com/-Tf2brsObTM8/T6PFWoQb9YI/AAAAAAAAANg/jUVNxIWHu4o/s800/020_exclamation.png "Exclamation icon"  
[cloud]: https://lh3.googleusercontent.com/-ClJCzZRU5EI/T6PFW82QdfI/AAAAAAAAANc/qHgqW0oWDc8/s800/021_cloud.png "Cloud icon"  
[cloud_up]: https://lh4.googleusercontent.com/-U21199OsCag/UArUxEStM8I/AAAAAAAAAQY/bTyMrP3Tf7c/s800/022_cloudUp2.png "Cloud UP icon"  
[cloud_down]: https://lh4.googleusercontent.com/-sIjKZWuAgvE/UArUxBBFHvI/AAAAAAAAAQc/4dkq6KIS2Sk/s800/023_cloudDown2.png "Cloud DOWN icon"  
[mail]: https://lh3.googleusercontent.com/-2jku23CPft0/T8TF6aqp6RI/AAAAAAAAAOA/V3CggQtEGrQ/s800/024_mail.png "Mail icon"  
[microphone]: https://lh6.googleusercontent.com/-4887D1xNGJc/T9wZESmsELI/AAAAAAAAAOQ/1b6KljBRKk8/s800/025_microphone.png "Microphone icon"  
[location]: https://lh5.googleusercontent.com/-YFwjubFI3Pg/T9wZES0HlWI/AAAAAAAAAOM/MDZbRF4O7dQ/s800/026_location.png "Location icon"  
[home]: https://lh3.googleusercontent.com/-_7I5KJ1koEk/T9wZEpL0eWI/AAAAAAAAAOU/HHAISS8BSIg/s800/027_home.png "Home icon"  
[tweet]: https://lh3.googleusercontent.com/-E7WdM3PlDdw/T9wZE31b7MI/AAAAAAAAAOk/H5lbspSEPXI/s800/028_tweet.png "Tweet icon"  
[clock]: https://lh5.googleusercontent.com/-pEnuvZie0DI/T-RY9Zh7IxI/AAAAAAAAAPw/xdG7SYt76WU/s800/029_clock.png "Clock icon"  
[wifi_full]: https://lh6.googleusercontent.com/-gTo8vjA2JFI/UArUMIhvJrI/AAAAAAAAAQE/WbwW9nIevPY/s800/030_wifiFull.png "Wifi Full icon"  
[wifi_empty]: https://lh6.googleusercontent.com/-X5-_-_8b4G0/UArUMF1PL1I/AAAAAAAAAQA/Bu3jWniYUPY/s800/031_wifiEmpty.png "Wifi Empty icon"  
