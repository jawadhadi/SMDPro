//
//  ViewController.h
//  iOSHacker
//
//  Created by Hadi on 21/05/2015.
//
//

#import <UIKit/UIKit.h>
@import iAd;

//@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
//{
//    ADBannerView *bannerView;
//}
//@end

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
{
    ADBannerView *bannerView;
    UIRefreshControl *refresh;
}

@end
