//
//  main.m
//  LPStackDemo
//
//  Created by Lance Parker on 8/25/13.
//  Copyright (c) 2013 Lance Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LPStack.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    
		LPStack *stack = [[LPStack alloc] init];
		
	    NSFileHandle *stdIn = [NSFileHandle fileHandleWithStandardInput];
		printf("Stack demo commands:\n");
		printf("'push #' -> pushes # onto the stack\n");
		printf("'pop' -> pops and prints the top of the stack\n");
		printf("'peek' -> prints but does not remove the top of the stack\n");
		printf("'print' -> prints the current stack from top to bottom\n");
		printf("'exit' -> stop the demo\n");
		for (;;) {
			NSData *inputData = [stdIn availableData];
			NSString *input = [[[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			if ([input isEqualToString:@"exit"]) {
				break;
			} else if ([input hasPrefix:@"push"]) {
				NSArray *components = [input componentsSeparatedByString:@" "];
				NSNumber *number = @([[components lastObject] integerValue]);
				[stack push:number];
			} else if ([input isEqualToString:@"pop"]) {
				printf("%ld\n", [[stack pop] longValue]);
			} else if ([input isEqualToString:@"peek"]) {
				printf("%ld\n", [[stack peek] longValue]);
			} else if ([input isEqualToString:@"print"]) {
				for (NSNumber *number in [stack allObjects]) {
					printf("%ld\n", [number longValue]);
				}
			} else {
				printf("Invalid input\n");
			}
		}
	    
	}
    return 0;
}

