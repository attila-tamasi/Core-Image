//
//  STAImageManager.h
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

@interface STAImageFactory : NSObject

- (UIImage *)imageWithImage:(UIImage *)targetImage filters:(NSArray *)filters;

@end
