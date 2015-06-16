//
//  TipViewController.m
//  iOSHacker
//
//  Created by Batool on 12/06/2015.
//
//

#import "TipViewController.h"
@import MessageUI;

@interface TipViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TipViewController



- (IBAction)composeEmail:(id)sender {
    
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc]init]; [mailcontroller setMailComposeDelegate:self];
    NSString *adress = @"hadi808@gmail.com";
    NSArray *adressArray = [[NSArray alloc]initWithObjects:adress, nil];
//    UIImage *myImage = [UIImage imageNamed:@"filename.png"];
    
    if (mailImage != nil) {
        NSData *imageData = UIImagePNGRepresentation(mailImage);
        [mailcontroller addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];
    }
    
    [mailcontroller setMessageBody:@"Write your Message here: " isHTML:NO];
    [mailcontroller setToRecipients:adressArray];
    [mailcontroller setSubject:@"Tip @ iOSHacker"];
    [mailcontroller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:mailcontroller animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        
//        imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        
//        [self presentViewController:imagePicker animated:YES completion:nil];
        
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        
        [cameraUI setDelegate:self];
        
        //[cameraUI setAllowsEditing:YES];
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController: cameraUI animated: YES completion:nil];
        
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
//    UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [capturedImage setImage:img];

    [picker dismissViewControllerAnimated:YES completion:Nil];
    
    [capturedImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    mailImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (IBAction)choosePhoto:(id)sender {
    
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentViewController:pickerLibrary animated:YES completion:nil];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
