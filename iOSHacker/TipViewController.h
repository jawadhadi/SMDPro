//
//  TipViewController.h
//  iOSHacker
//
//  Created by Batool on 12/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface TipViewController : UIViewController
{
    UIImagePickerController* imagePicker;
    
    IBOutlet UIImageView *capturedImage;
    
    UIImage* mailImage;
    
}

- (IBAction)takePhoto:(id)sender;


@end
