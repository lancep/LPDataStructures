//
//  main.m
//  LPPriorityQueueDemo
//
//  Created by Lance Parker on 8/25/13.
//  Copyright (c) 2013 Lance Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LPPriorityQueue.h"

int main(int argc, const char * argv[])
{
	
	@autoreleasepool {
	    
		LPPriorityQueue *queue = [[LPPriorityQueue alloc] initWithComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
			return [obj1 compare:obj2];
		}];
		
	    NSFileHandle *stdIn = [NSFileHandle fileHandleWithStandardInput];
		printf("PriorityQueue demo commands:\n");
		printf("'add #' -> pushes # onto the stack\n");
		printf("'dequeue' -> dequeues and prints the highest priority value of the queue\n");
		printf("'first' -> prints but does not remove the highest priority value\n");
		printf("'print' -> prints the current queue from hightest to lowest priority\n");
		printf("'exit' -> stop the demo\n");
		for (;;) {
			NSData *inputData = [stdIn availableData];
			NSString *input = [[[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			if ([input isEqualToString:@"exit"]) {
				break;
			} else if ([input hasPrefix:@"add"]) {
				NSArray *components = [input componentsSeparatedByString:@" "];
				NSNumber *number = @([[components lastObject] integerValue]);
				[queue addObject:number];
			} else if ([input isEqualToString:@"dequeue"]) {
				printf("%ld\n", [[queue dequeue] longValue]);
			} else if ([input isEqualToString:@"first"]) {
				printf("%ld\n", [[queue firstObject] longValue]);
			} else if ([input isEqualToString:@"print"]) {
				for (NSNumber *number in [queue allObjects]) {
					printf("%ld\n", [number longValue]);
				}
			} else {
				printf("Invalid input\n");
			}
		}
	    
	}
    return 0;
}

