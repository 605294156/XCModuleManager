//
//  XCModuleManager.h
//  
//
//  Created by XiaoCheng on 05/08/2019.
//  Copyright © 2019 赵思集团. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@import UIKit;

@protocol XCModule <UIApplicationDelegate>

@end

@interface XCModuleManager : NSObject<UIApplicationDelegate>
+ (instancetype)sharedInstance;

- (NSArray<id<XCModule>> *)allModules;
@end

NS_ASSUME_NONNULL_END
