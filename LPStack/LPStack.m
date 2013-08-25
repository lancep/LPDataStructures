//
//  LPStack.m
//  LPStackDemo
//
//  Created by Lance Parker on 8/25/13.
//  Copyright (c) 2013 Lance Parker. All rights reserved.
//

#import "LPStack.h"

@interface LPStack ()
@property (strong, nonatomic) NSMutableArray *storage;
@end

@implementation LPStack

- (id)init {
	if (self = [super init]) {
		_storage = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)push:(id)object {
	[self.storage addObject:object];
}

- (id)peek {
	return [self.storage lastObject];
}

- (id)pop {
	NSInteger index = self.storage.count - 1;
	id object = nil;
	if (index >= 0) {
		object = self.storage[index];
		[self.storage removeObjectAtIndex:index];
	}
	return object;
}

- (NSArray *)allObjects {
	return [[self.storage reverseObjectEnumerator] allObjects];
}

- (void)removeAllObjects {
	[self.storage removeAllObjects];
}

- (NSUInteger)count {
	return self.storage.count;
}

@end
