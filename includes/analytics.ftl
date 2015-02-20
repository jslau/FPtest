<#attempt>

<#assign rand=tool.util.getRandom().nextInt()!'abc123'?string />

<#--

<@editor.paragraph text="Page ID=${page.id}" />
<@editor.paragraph text="Page Params=${page.params}" />
-->
	<#if     (page.name?contains("article.ftl")) && !(page.name?contains("rock")) && (page.params?contains("Latest News"))>
		<#assign tag = "eonline-news-detail" />
	<#elseif (page.name?contains("article_list.ftl")) && (page.params?contains("Latest News"))>
		<#assign tag = "eonline-news-recent-index" />
	<#elseif (page.name?contains("video"))>
		<#assign tag = "eonline-video-index" />
	<#elseif (page.name?contains("photo_list")) && (page.params?contains("Photos"))>
		<#assign tag = "eonline-photos-index" />
	<#elseif ((page.name?contains("photo.ftl")) && (page.params?contains("gid=6")))>
		<#assign tag = "eonline-photos-bigpicture" />
	<#elseif ((page.name?contains("photo-archive.ftl")) && (page.params?contains("galleryId=6")))>
		<#assign tag = "eonline-photos-bigpicture" />
	<#elseif (page.name?contains("photo.ftl")) && (page.params?contains("gid=233"))>
		<#assign tag = "eonline-photos-fashionpolice" />
	<#elseif (page.name?contains("photo-archive.ftl")) && (page.params?contains("galleryId=233"))>
		<#assign tag = "eonline-photos-fashionpolice" />
	<#elseif (page.name?contains("photo.ftl")) || (page.name?contains("photo-archive.ftl"))>
		<#assign tag = "eonline-photos-other" />

	<#elseif (page.name?contains("article.ftl")) && (page.params?contains("Awful Truth"))>
		<#assign tag = "eonline-aweful-detail" />
	<#elseif (page.name?contains("article_list.ftl")) && (page.params?contains("Awful Truth"))>
		<#assign tag = "eonline-aweful-index" />
	<#elseif (page.name?contains("article.ftl")) && (page.params?contains("Watch w/Kristin"))>
		<#assign tag = "eonline-wwk-detail" />
	<#elseif (page.name?contains("article_list.ftl")) && (page.params?contains("Watch w/Kristin"))>
		<#assign tag = "eonline-wwk-index" />
	<#elseif (page.name?contains("rock/index.ftl"))>
		<#assign tag = "eonline-rock-index" />
	<#elseif (page.name?contains("rock/article.ftl"))>
		<#assign tag = "eonline-rock-detail" />

	<#elseif (page.name?contains("show_list"))>
		<#assign tag = "eonline-shows-index" />
	<#elseif (page.name?contains("shows/kktny"))>
		<#assign tag = "eonline-shows-kktny" />
	<#elseif (page.name?contains("shows/fp"))>
		<#assign tag = "eonline-shows-fp" />
	<#elseif (page.name?contains("shows/kktm"))>
		<#assign tag = "eonline-shows-kktm" />
	<#elseif (page.name?contains("shows/ch"))>
		<#assign tag = "eonline-shows-ch" />
	<#elseif (page.name?contains("shows/klamar"))>
		<#assign tag = "eonline-shows-klamar" />
	<#elseif (page.name?contains("shows/soup"))>
		<#assign tag = "eonline-shows-soup" />
	<#elseif (page.name?contains("shows/enews"))>
		<#assign tag = "eonline-shows-enews" />

	<#elseif (page.name?contains("tv_schedule"))>
		<#assign tag = "eonline-shows-schedule" />

	<#elseif (page.name?contains("article_list.ftl")) && (page.params?contains("Red Carpet"))>
		<#assign tag = "eonline-redcarpet-index" />
	<#elseif (page.name?contains("article.ftl")) && (page.params?contains("Red Carpet"))>
		<#assign tag = "eonline-redcarpet-detail" />
	<#elseif (page.name?contains("article_list.ftl")) && (page.params?contains("Movie Reviews"))>
		<#assign tag = "eonline-moviereviews" />
	<#elseif (page.name?contains("article.ftl")) && (page.params?contains("Red Carpet"))>
		<#assign tag = "eonline-moviereviews-detail" />

	<#elseif (page.name?contains("apps_list")) && ((ua?contains("iPhone")) || (ua?contains("iPad")))>
		<#assign tag = "eonline-iphone-apps" />
	<#elseif (page.name?contains("apps_list")) && (ua?contains("Android"))>
		<#assign tag = "eonline-android-apps" />

	<#elseif (page.name?contains("article.ftl"))>
		<#assign tag = "eonline-news-detail" />
	<#else>
		<#assign tag = "eonline-news-index" />
	</#if>
	<#--
	<#if ua?contains('iPad') >
	<img src="http://wa.eonline.com/b/ss/comcastegeonlinemobile/5/H.20.3--WAP?pageName=ipad%3A${tag}&amp;state=${rand}" alt="iPad"/> 
	<#elseif ua?contains('Android') >
	<img src="http://wa.eonline.com/b/ss/comcastegeonlinemobile/5/H.20.3--WAP?pageName=android%3A${tag}&amp;state=${rand}" alt="Android"/> 
	<#elseif (ua?contains('iPhone')) || (ua?contains('iPod'))>
	<img src="http://wa.eonline.com/b/ss/comcastegeonlinemobile/5/H.20.3--WAP?pageName=iphone%3A${tag}&amp;state=${rand}" alt="iPhone"/>
	<#else>
	<img src="http://wa.eonline.com/b/ss/comcastegeonlinemobile/5/H.20.3--WAP?pageName=tsundef%3A${tag}&amp;state=${rand}" alt="Undefined Device"/>
	</#if>
-->
<#recover>
</#attempt>
