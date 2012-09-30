/*
 * (c) Sergei Cherepanov, 2012
 */
#import "NSDate+IHNDateCalculations.h"

#if !__has_feature(objc_arc)
    #error NSDate+IHNDateCalculations requires ARC support.
#endif

@implementation NSDate (IHNDateCalculations)

#pragma mark - Comparison
- (BOOL) isEarlierThan:(NSDate *)anotherDate
{
    NSParameterAssert(anotherDate != nil);
    return [self compare:anotherDate] == NSOrderedAscending;
}

- (BOOL) isEqualOrEarlierThan:(NSDate *)anotherDate
{
    NSParameterAssert(anotherDate != nil);
    return [self compare:anotherDate] != NSOrderedDescending;
}

- (BOOL) isLaterThan:(NSDate *)anotherDate
{
    NSParameterAssert(anotherDate != nil);
    return [self compare:anotherDate] == NSOrderedDescending;
}

- (BOOL) isEqualOrLaterThan:(NSDate *)anotherDate
{
    NSParameterAssert(anotherDate != nil);
    return [self compare:anotherDate] != NSOrderedAscending;
}


#pragma mark - Before
- (NSDate *) monthsAgo:(NSInteger)months
{
    NSParameterAssert(months >= 0);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:-months];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *) monthAgo
{
    return [self monthsAgo:1];
}

- (NSDate *) daysAgo:(NSInteger)days
{
    NSParameterAssert(days >= 0);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:-days];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *) dayAgo
{
    return [self daysAgo:1];
}


#pragma mark - After
- (NSDate *) monthsAfter:(NSInteger)months
{
    NSParameterAssert(months >= 0);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:months];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *) monthAfter
{
    return [self monthsAfter:1];
}

- (NSDate *) daysAfter:(NSInteger)days
{
    NSParameterAssert(days >= 0);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:days];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *) dayAfter
{
    return [self daysAfter:1];
}
@end
