//
//  PostViewController.m
//  iOSHacker
//
//  Created by Hadi on 31/05/2015.
//
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    NSString* feedContent = [NSString stringWithFormat:@"<h3>%@</h3>%@", self.postTitle, self.postContent];
    [self.postArea loadHTMLString:feedContent baseURL:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareButton:(id)sender {
    
    NSString* tempTitle = self.postTitle;
    
    NSURL* tempURL = [NSURL URLWithString:self.url];
    
    [self shareText:tempTitle andImage:nil andUrl:tempURL];
}
//
//- (IBAction)shareButton:(UIButton *)sender {
//    
//    
//}


- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
