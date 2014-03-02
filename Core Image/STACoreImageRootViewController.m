//
//  STACoreImageRootViewController.m
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STACoreImageRootViewController.h"
#import "STAImageFactory.h"
#import "STAFilterManager.h"
#import "STANetworkSessionUploadTask.h"
#import "STANetworkRequest.h"

@interface STACoreImageRootViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *originalImage;

@property (nonatomic, strong) STANetworkSessionUploadTask *upload;

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

@implementation STACoreImageRootViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self renderImageWithEnabledFilters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    self.imagePicker = nil;
}

- (void)presentImagePickerControllerWithSourceStyle:(UIImagePickerControllerSourceType)pickerControllerSourceType
{
    if (self.imagePicker == nil)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
    }

    self.imagePicker.sourceType = pickerControllerSourceType;

    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - interface action methods

- (IBAction)prepareImageSelector:(id)sender
{
    [self presentImagePickerControllerWithSourceStyle:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)shareButtonPressed:(id)sender
{
    NSString *title = NSLocalizedString(@"Confirmation", @"Confirmation title");
    NSString *message = NSLocalizedString(@"Do you want to upload your image to server?", @"Confirmation message");
    NSString *cancel = NSLocalizedString(@"Cancel", @"Cancel");
    NSString *ok = NSLocalizedString(@"Ok", @"Ok");

    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:ok, nil] show];
}

- (void)renderImageWithEnabledFilters
{
    __block UIImage *effectedImage;

    dispatchOnBackgroundQueue (^{

        STAImageFactory *imageManager = [[STAImageFactory alloc] init];

        NSArray *filters = [[STAFilterManager sharedInstance] availableCoreImageFilters];

        effectedImage = [imageManager imageWithImage:self.originalImage filters:filters];

        dispatchOnMainQueue (^{
                self.imageView.image = effectedImage;
            });
    });
}

#pragma mark - image picker controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (info)
    {
        UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];

        [[STAFilterManager sharedInstance] resetFilters];

        self.imageView.image = image;
        self.originalImage = image;

        dispatchOnMainQueue (^{
            [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        STANetworkRequest *request = [[STANetworkRequest alloc] init];

#warning ENDPOINT URL MISSING
        request.path = @"";
        request.bodyObject = UIImageJPEGRepresentation(self.imageView.image, 0.7);

        self.upload = [[STANetworkSessionUploadTask alloc] initWithRequest:request completionBlock:^(id response, NSError *error, NSUInteger stutsCode) {

            if (!error)
            {
                self.progressBar.progress = 0.0;

                [[[UIAlertView alloc] initWithTitle:@"Upload finished" message:@"Image uploaded correctly." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }

        } progressBlock:^(float progress) {
            self.progressBar.progress = progress;
        }];

        [self.upload execute];
    }
}

@end
