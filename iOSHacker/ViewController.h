//
//  ViewController.h
//  iOSHacker
//
//  Created by Hadi on 21/05/2015.
//
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"
#import "DBManager.h"
@import iAd;

@interface ViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>
{
    ADBannerView *bannerView;
    
}

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableArray *attachments;
//@property (nonatomic, strong) NSMutableArray *urls;

@property (nonatomic, strong) IBOutlet UITableView* postsView;


-(void)refreshView:(UIRefreshControl *)refresh;
-(void) saveInfo;
-(void) loadData;

@end
