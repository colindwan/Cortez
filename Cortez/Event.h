//
//  Event.h
//  Cortez
//
//  Created by COLIN DWAN on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Event : NSObject {
    unsigned int    iEventId;
    unsigned int    iState;
    
    NSString        *sEventName;
    
    NSString        *sGoalName;
    unsigned int    iGoalFlags;
}

@property (nonatomic, readonly) unsigned int    iEventId;
@property (nonatomic)           unsigned int    iState;
@property (nonatomic, retain)   NSString        *sEventName;
@property (nonatomic, retain)   NSString        *sGoalName;
@property (nonatomic)           unsigned int    iGoalFlags;

@end
