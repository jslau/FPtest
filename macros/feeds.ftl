  <#-- RSS FEEDS -->
  <#-- us version
       <#assign feeds = {"article"            : "http://syndication.eonline.com/syndication/feeds/iphone/news/detail.xml?id=",
                         "Latest News"        : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1", 
   -->
 <#--
     http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/common/news/news_detail.jsp?blogID=377169&ed=fr
     http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=fr&category=top_stories
 -->
              
  <#assign feeds = {"article"            : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/common/news/news_detail.jsp?blogID=",
                    "Latest News"        : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml",
                    "Mark Malkin"        : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=2",
                    "Answer Bitch"       : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=3",
                    "Party Girl"         : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=4",
                    "Lyon's Den"         : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=5",
                    "Watch w/ Kristin"   : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=6",
                    "Awful Truth"        : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=7",
                    "Red Carpet"         : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=8",
                    "Movie Reviews"      : "http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=9",
                    "Videos"             : "http://syndication.eonline.com/syndication/feeds/iphone/video/latest.xml",
                    "tvschedule"         : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/schedule.xml",
                    "celebpics"          : "http://www.eonline.com/syndication/feeds/partners/mobile/iloop/tv_celebs.xml",
                    "Photo Galleries All": "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=de",
                    "Photo Galleries"    : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=de",
                    "gallery"     : "http://syndication.eonline.com/syndication/feeds/iphone/photos/dynamic_gallery.jsp?gallery=",
                    "hw"          : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_holly.xml",
                    "hw_party"    : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_holly.xml?gallery=2240",
                    "kar_passion" : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kardashians.xml?cat=6",
                    "kar_karpet"  : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kardashians.xml?cat=2314",
                    "kar_karpet"  : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kardashians.xml?cat=2352",
                    "kar_karpet"  : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kardashians.xml?cat=2367",
                    "kar_karpet"  : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kardashians.xml?cat=2368",
                    "ken_child"   : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kendra.xml?cat=1",
                    "ken_hank"    : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kendra.xml?cat=2",
                    "ken_baby"    : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kendra.xml?cat=3",
                    "ken_wedding" : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kendra.xml?cat=4",
                    "kk_takemiami": "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kk.xml?gallery=1304",
                    "kk_wedding"  : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kk.xml?gallery=1519",
                    "kk_strip"    : "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kk.xml?gallery=2069",
                    "kk_miaminice": "http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/micro/eol_kk.xml?gallery=2134",
                    "soup_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/galleries.xml",
                    "soup_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/video_common.xml",
                    "soup_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/news.xml",
                    "kktny_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktny/galleries.xml",
                    "kktny_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktny/video.xml",
                    "kktny_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktny/news.xml",
                    "fp_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/fashionpolice/galleries.xml",
                    "fp_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/fashionpolice/video.xml",
                    "fp_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/fashionpolice/news.xml",
                    "kktm_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktm/galleries.xml",
                    "kktm_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktm/video.xml",
                    "kktm_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kktm/news.xml",
                    "ch_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/chelsea/galleries.xml",
                    "ch_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/chelsea/video.xml",
                    "ch_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/chelsea/news.xml",
                    "enews_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/enewsnow/galleries.xml",
                    "enews_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/enewsnow/video.xml",
                    "enews_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/enewsnow/news.xml",
                    "klamar_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/klamar/galleries.xml",
                    "klamar_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/klamar/video.xml",
                    "klamar_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/klamar/news.xml",
                    "kuwtk_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kuwtk/galleries.xml",
                    "kuwtk_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/common/videos_ws.jsp?programId=129&show=kuwtk&total=5", 
                    "kuwtk_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/kuwtk/news.xml",
                    "Shows"       : "http://" + page.request.getServerName() + "/xml/homefeed/showsfeed.ftl",
                    "Apps"        : "http://" + page.request.getServerName() + "/xml/appsfeed.ftl",
                    "thesoup_clips"  : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/app/videos/videos.xml",
                   "thesoup_news"    : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/news_web.xml?category=the_soup",
                   "thesoup_hof"      : "http://syndication.eonline.com/syndication/feeds/mobile/apps/soup/app/videos/hof.xml",
                   "openingact_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/openingact/web/galleries.xml",
                   "openingact_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/openingact/web/videos.xml",
                   "openingact_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/openingact/web/news.xml",
                   "jonas_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/marriedtojonas/galleries.xml",
                   "jonas_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/marriedtojonas/videos.xml?total=5",
                   "jonas_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/marriedtojonas/news.xml",
                   "redcarpet_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/lrc/web/galleries.xml?cat=Red_Carpet,premieres,2012_Emmys,2012_Sundance,2012_SAG_Awards,2012_Oscars,2012_Golden_Globes",
                   "redcarpet_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/lrc/web/lrcshowpackage/videos.xml?key=current",
                   "redcarpet_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/lrc/web/news.xml?cat=Red_Carpet,premieres,2012_Emmys,2012_Sundance,2012_SAG_Awards,2012_Oscars,2012_Golden_Globes",
                   "trends_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/trends/galleries.xml",
                   "trends_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/trends/videos.xml?keywords=living,fashion,beauty",
                   "trends_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/trends/news.xml",
                   "lymi_photos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/loveumeanit/galleries.xml",
                   "lymi_videos" : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/loveumeanit/videos.xml",
                   "lymi_news"   : "http://syndication.eonline.com/syndication/feeds/mobile/apps/eonline/web/loveumeanit/news.xml",
                   "TV"   : "    http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=10"
                    
                    } />

<#--
NEWS (de/fr/it/uk)
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=de
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=fr
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=it

PHOTOS (de/fr/it/uk)
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=de
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=fr
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=it
http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk

VIDEOS (de/fr/uk)
Germany (de) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=de_row_intl_video_masterfeed
France (fr) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=fr_row_intl_video_masterfeed
UK (uk) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed
IT (it) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=it_row_intl_video_masterfeed
-->