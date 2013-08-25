//
//  LPStack.h
//  LPStackDemo
//
//  Created by Lance Parker on 8/25/13.
//  Copyright (c) 2013 Lance Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPStack : NSObject

- (void)push:(id)object;
- (id)peek;
- (id)pop;
- (NSArray *)allObjects;
- (void)removeAllObjects;
- (NSUInteger)count;

@end
