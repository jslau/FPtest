<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@u.getDeviceDimension />

<apps>
   <platform>
      <name>iPhone</name>
      <items>
         <item><title>E! Online</title>
            <imgurl>images/iphone_logos/148eol.png</imgurl>
            <linkurl>${tool.text.eOniTunes}</linkurl>
         </item>
         <item><title>Keeping Up with the Kardashians</title>
            <imgurl>images/iphone_logos/148kuwtk.png</imgurl>
            <linkurl>${tool.text.KUWTKOniTunes}</linkurl>
         </item>
         <item><title>Live From the Red Carpet</title>
            <imgurl>images/iphone_logos/148lrc.png</imgurl>
            <linkurl>${tool.text.LRCOniTunes}</linkurl>
         </item>
         <item><title>Fashion Police</title>
            <imgurl>images/iphone_logos/148FP1.png</imgurl>
            <linkurl>${tool.text.FPOniTunes}</linkurl>
         </item>
	 <item><title>The Soup</title>
            <imgurl>images/iphone_logos/148Soup1.png</imgurl>
            <linkurl>${tool.text.SOUPOniTunes}</linkurl>
         </item>

<#--ROHAN.JAIN  11/14/2012 Removing G4 from iPhone -->
<#--    <item><title>G4</title>
            <imgurl>images/iphone_logos/G4.png</imgurl>
            <linkurl>${tool.text.g4OniTunes}</linkurl>
         </item> -->
<#-- END Rohan.Jain -->

      </items>
   </platform>
   <platform>
      <name>iPad</name>
      <items>
         <item><title>Live From the Red Carpet</title>
            <imgurl>images/iphone_logos/LFRC.jpg</imgurl>
            <linkurl>${tool.text.LRCOniTunes}</linkurl>
         </item>
      </items>
   </platform>
   <platform>
      <name>Android Mobile</name>
      <items>
         <item><title>E! Online</title>
            <imgurl>images/android_logos/148eol.png</imgurl>
            <linkurl>${tool.text.eOnAndroidMarket}</linkurl>
         </item>
         <item><title>Keeping Up with the Kardashians</title>
            <imgurl>images/android_logos/148kuwtk.png</imgurl>
            <linkurl>${tool.text.KUWTKOnAndroidMarket}</linkurl>
         </item>
         <item><title>Live From the Red Carpet</title>
            <imgurl>images/android_logos/148lrc.png</imgurl>
            <linkurl>${tool.text.LRCOnOnAndroidMarket}</linkurl>
         </item>
         <item><title>Fashion Police</title>
            <imgurl>images/android_logos/148FP1.png</imgurl>
            <linkurl>${tool.text.FPOnAndroidMarket}</linkurl>
         </item>
	 <item><title>The Soup</title>
            <imgurl>images/android_logos/148Soup1.png</imgurl>
            <linkurl>${tool.text.SOUPOnAndroidMarket}</linkurl>
         </item>
<#--<item><title>Wild On</title>
            <imgurl>images/android_logos/WildOn.png</imgurl>
            <linkurl>${tool.text.wildOnOnAndroidMarket}</linkurl>
         </item>
         <item><title>G4</title>
            <imgurl>images/android_logos/G4.gif</imgurl>
            <linkurl>${tool.text.g4OnAndroidMarket}</linkurl>
         </item> -->
      </items>
   </platform>
   <platform>
      <name>Android Tablet</name>
      <items>
      </items>
   </platform>
</apps>