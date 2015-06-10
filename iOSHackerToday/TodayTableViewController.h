//
//  TodayTableViewController.h
//  iOSHacker
//
//  Created by Hadi on 07/06/2015.
//
//

#import <UIKit/UIKit.h>
@import NotificationCenter;

@interface TodayTableViewController : UITableViewController <NCWidgetProviding>


@property (nonatomic, strong) NSArray* posts;
@property (nonatomic, strong) NSMutableArray *attachments;

@end
