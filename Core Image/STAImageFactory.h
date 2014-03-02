//
//  STAImageManager.h
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

/**
 *  Image Factory
 *
 *  Image factory based on filter objects
 */
@interface STAImageFactory : NSObject

/**
 *  Filtered image factory method
 *
 *  @param targetImage UIImage to filter
 *  @param filters     Filters collecton, w STAImageFilter objects
 *
 *  @return filtered UIImage image
 */
- (UIImage *)imageWithImage:(UIImage *)targetImage filters:(NSArray *)filters;

@end
