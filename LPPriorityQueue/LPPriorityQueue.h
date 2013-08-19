//
//  LPPriorityQueue.h
//  EightPuzzle
//
//  Created by Lance Parker on 9/15/12.
//  Copyright (c) 2012 Lance Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface LPPriorityQueue : NSObject

- (id)initWithComparator:(NSComparator)comparator;

- (NSUInteger)count;
- (void)addObject:(id)obj;
- (id)popFirstObject;
- (void)removeFirstObject;
- (id)firstObject;
- (NSArray *)allObjects;
- (void)removeAllObjects;

@end
