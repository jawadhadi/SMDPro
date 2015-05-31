//
//  ViewController.h
//  iOSHacker
//
//  Created by Hadi on 21/05/2015.
//
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"
@import iAd;

//@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
//{
//    ADBannerView *bannerView;
//}
//@end

@interface ViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
{
    ADBannerView *bannerView;
    //UIRefreshControl *refresh;
    
}

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSMutableArray *attachments;
@property (nonatomic, strong) NSMutableArray *urls;

@property (nonatomic, strong) IBOutlet UITableView* postsView;


-(void)refreshView:(UIRefreshControl *)refresh;

@end
