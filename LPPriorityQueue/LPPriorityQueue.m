//
//  LPPriorityQueue.m
//  EightPuzzle
//
//  Created by Lance Parker on 9/15/12.
//  Copyright (c) 2012 Lance Parker. All rights reserved.
//

#import "LPPriorityQueue.h"

@interface LPNode : NSObject

- (id)initWithContent:(id)content comparator:(NSComparator)comparator;

@property (readonly, strong) id content;
@property (readwrite, weak) NSComparator comparator;
@end

@implementation LPNode

- (id)initWithContent:(id)content comparator:(NSComparator)comparator {
    if ((self = [super init])) {
        _content = content;
        _comparator = comparator;
    }
    return self;
    
}

@end

const void *nretain(CFAllocatorRef allocator, const void *ptr) {
    return CFRetain(ptr);
}

void nrelease(CFAllocatorRef allocator, const void *ptr) {
    CFRelease(ptr);
}

CFComparisonResult ncompare(const void *ptr1, const void *ptr2, void *info) {
    LPNode *node1 = (__bridge LPNode *)ptr1;
    LPNode *node2 = (__bridge LPNode *)ptr2;
    NSComparator comparator = [node1 comparator];
    return (CFComparisonResult)comparator(node1.content, node2.content);
}

static CFStringRef ncopyDescription(const void* ptr) {
    LPNode *node = (__bridge LPNode *)ptr;
    CFStringRef desc = (__bridge CFStringRef) [node description];
    return desc;
}

CFBinaryHeapCallBacks callbacks = { 0, nretain, nrelease, ncopyDescription, ncompare };

@interface LPPriorityQueue() {
    CFBinaryHeapRef _heap;
}

@property (readonly, copy) NSComparator comparator;

@end

@implementation LPPriorityQueue

- (id)initWithComparator:(NSComparator)comparator {
    if ((self = [super init])){
        _heap = CFBinaryHeapCreate(kCFAllocatorDefault, 0, &callbacks, NULL);
        _comparator = comparator;
    }
    return self;
}

- (NSUInteger)count {
    CFIndex c = CFBinaryHeapGetCount(_heap);
    NSAssert(c >= 0, @"Invalid heap count: %ld", c);
    return (NSUInteger)c;
}

- (void)addObject:(id)obj {
    NSAssert(obj != nil, @"Attept to insert nil object into priority queue.");
    NSAssert(self.comparator != NULL, @"Null comparator in priority queue.");
    LPNode *node = [[LPNode alloc] initWithContent:obj comparator:self.comparator];
    node.comparator = self.comparator;
    CFBinaryHeapAddValue(_heap, (__bridge_retained void *)node);
}

- (id)dequeue {
    CFTypeRef cfNode = NULL;
    Boolean success = CFBinaryHeapGetMinimumIfPresent(_heap, (const void **)&cfNode);
    if (success) {
        LPNode *node = (__bridge LPNode*)cfNode;
        CFTypeRef content = (__bridge CFTypeRef)(node.content);
        [self removeFirstObject];
        return (__bridge_transfer id) content;
    } else {
        return nil;
    }
}

- (void)removeFirstObject
{
    NSAssert(CFBinaryHeapGetCount(_heap) > 0, @"Attemt to remove from empty queue");
    CFBinaryHeapRemoveMinimumValue(_heap);
}

- (id)firstObject {
    CFTypeRef cfNode = NULL;
    Boolean res = CFBinaryHeapGetMinimumIfPresent(_heap, (const void **)&cfNode);
    if (res) {
        LPNode *node = (__bridge LPNode *) cfNode;
        return node.content;
    } else {
        return nil;
    }
}

- (NSArray *)allObjects {
    CFIndex size = CFBinaryHeapGetCount(_heap);
    CFTypeRef *cfValues = malloc(size * sizeof(CFTypeRef));
    CFBinaryHeapGetValues(_heap, (const void **)cfValues);
    CFArrayRef nodes = CFArrayCreate(kCFAllocatorDefault, cfValues, size, &kCFTypeArrayCallBacks);
    CFIndex count = CFArrayGetCount(nodes);
    CFMutableArrayRef objects = CFArrayCreateMutable(kCFAllocatorDefault, count, &kCFTypeArrayCallBacks);
    for (CFIndex i = 0; i < count; i++) {
        LPNode *node = (__bridge_transfer LPNode *)CFArrayGetValueAtIndex(nodes, i);
        id object = node.content;
        CFArrayAppendValue(objects, (__bridge_retained CFTypeRef) object);
    }
    free(cfValues);
    return (__bridge_transfer NSMutableArray *) objects;
}


- (void)removeAllObjects {
    CFBinaryHeapRemoveAllValues(_heap);
}

- (void)dealloc {
    CFRelease(_heap);
}

@end