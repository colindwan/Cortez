//
//  EventDetailsOverlay.h
//  Cortez
//
//  Created by COLIN DWAN on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class Event;

@interface EventDetailsOverlay : CCLayer {
    Event *myEvent;
}

// returns a CCScene that contains the EventDetailsOverlay as the only child
+(CCScene *) scene;

- (id)initWithEvent:(Event *)pEvent;

- (void)setupEventDetails;
- (void)lockEventDetails;
- (void)unlockEventDetails;

@end
