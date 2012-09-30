/*
 * (c) Sergei Cherepanov, 2012
 */
#import <SenTestingKit/SenTestingKit.h>
#import "NSDate+IHNDateCalculations.h"

@interface IHNDateCalculationsTests : SenTestCase
{
    NSDateFormatter *dateFormatter;
    NSDate *now, *arbitraryFutureDate, *arbitraryPastDate;
}
@end

#pragma mark -
@implementation IHNDateCalculationsTests
- (BOOL) date:(NSDate *)date1 and:(NSDate *)date2 differByYears:(NSInteger)years months:(NSInteger)months
         days:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                                                    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                          fromDate:date1 toDate:date2 options:0];
    STAssertNotNil(comps, @"Date components cannot be retrieved.");
    return comps.year == years && comps.month == months && comps.day == days &&
            comps.hour == hours && comps.minute == minutes && comps.second == seconds;
}

- (void) setUp
{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(7 * 60 * 60)]];
    
    now = [NSDate date];
    arbitraryFutureDate = [dateFormatter dateFromString:@"2031-11-20T21:12:59Z"];
    STAssertNotNil(arbitraryFutureDate, @"Date can't be initialized from string");
    arbitraryPastDate = [dateFormatter dateFromString:@"2011-06-23T11:50:23Z"];
    STAssertNotNil(arbitraryPastDate, @"Date can't be initialized from string");
    
    // Checking if date comparison helpers actually work.
    STAssertTrue([self date:now and:now differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:1 months:0
                        days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:1
                        days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:1 hours:0 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:1 minutes:0 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:0 minutes:1 seconds:0], @"");
    STAssertFalse([self date:now and:now differByYears:0 months:0
                        days:0 hours:0 minutes:0 seconds:1], @"");
    STAssertTrue([self date:arbitraryPastDate and:arbitraryFutureDate differByYears:20 months:4
                       days:28 hours:9 minutes:22 seconds:36], @"");
    STAssertTrue([self date:arbitraryFutureDate and:arbitraryPastDate differByYears:-20 months:-4
                       days:-27 hours:-9 minutes:-22 seconds:-36], @"");
}

- (void) testMothsAgo
{
    NSDate *monthsAgo = [arbitraryPastDate monthsAgo:2];
    STAssertTrue([self date:monthsAgo and:arbitraryPastDate differByYears:0 months:2
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAgo = [now monthsAgo:8];
    STAssertTrue([self date:monthsAgo and:now differByYears:0 months:8
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthsAgo = [arbitraryFutureDate monthsAgo:0];
    STAssertTrue([self date:monthsAgo and:arbitraryFutureDate differByYears:0 months:0
                       days:0 hours:0 minutes:0 seconds:0], @"");
    STAssertThrows([now monthsAgo:-1], @"");
}

- (void) testMonthAgo
{
    NSDate *monthAgo = [arbitraryPastDate monthAgo];
    STAssertTrue([self date:monthAgo and:arbitraryPastDate differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAgo = [now monthAgo];
    STAssertTrue([self date:monthAgo and:now differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
    monthAgo = [arbitraryFutureDate monthAgo];
    STAssertTrue([self date:monthAgo and:arbitraryFutureDate differByYears:0 months:1
                       days:0 hours:0 minutes:0 seconds:0], @"");
}
@end
