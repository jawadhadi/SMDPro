//
//  PostViewController.h
//  iOSHacker
//
//  Created by Hadi on 31/05/2015.
//
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PostViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *postArea;
@property (strong, nonatomic) NSString* postTitle;
@property (strong, nonatomic) NSString* postContent;
@property (strong, nonatomic) NSString* url;


@end
