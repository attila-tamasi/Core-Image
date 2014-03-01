//
//  STACoreImageRootViewController.m
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STACoreImageRootViewController.h"

@interface STACoreImageRootViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation STACoreImageRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - image picker controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (info)
    {
        UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];

        self.imageView.image = image;

        dispatchOnMainQueue (^{
            [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

@end