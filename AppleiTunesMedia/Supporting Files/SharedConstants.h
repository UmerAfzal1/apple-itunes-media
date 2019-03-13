//
//  SharedConstants.h
//  AppleiTunesMedia
//
//  Created by Umer Afzal on 13/03/2019.
//  Copyright © 2019 Umer Afzal. All rights reserved.
//

#ifndef SharedConstants_h
#define SharedConstants_h


#define APPLE_MEDIA_BASE_URL @"https://rss.itunes.apple.com/api/v1/us/%@/all/10/explicit.json"

#define APPLE_MUSIC @"apple-music/coming-soon"
#define MOIVE @"movies/top-movies"
#define TVSHOW @"tv-shows/top-tv-episodes"
#define ITUNES_MUSIC @"itunes-music/hot-tracks"
#define IOS_APPS @"ios-apps/new-apps-we-love"



typedef enum{
    GET,
    POST
}RequestType;

typedef enum{
    APPLEMUSIC,
    MOVIES,
    TVSHOWS,
    ITUNESMUSIC,
    IOSAPP
}MediaType;



#endif /* SharedConstants_h */
