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

@interface STACoreImageRootViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *originalImage;

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
    dispatchOnMainQueue (^{

        STAImageFactory *imageManager = [[STAImageFactory alloc] init];

        NSArray *filters = [[STAFilterManager sharedInstance] availableCoreImageFilters];

        self.imageView.image = [imageManager imageWithImage:self.originalImage filters:filters];
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

@end
