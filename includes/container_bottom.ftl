<#-- 
    includes/container_bottom.ftl 
-->

<#attempt>
   <#assign lang = .globals.fixTransl?number />
<#recover>
   <#assign lang = 1 />
</#attempt>

<#assign thisUrl=page.request.getServerName()/>

<#if lang == 0><#-- GB -->
  <#assign footerHomeImg = '/images/international/GB/Footer_Home.png' />
<#elseif lang == 1><#-- FR -->
  <#assign footerHomeImg = '/images/international/French/Footer_Home.png' />
<#elseif lang == 2><#-- IT -->
  <#assign footerHomeImg = '/images/international/Italian/Footer_Home.png' />
<#elseif lang == 3><#-- DE -->
  <#assign footerHomeImg = '/images/international/German/Footer_Home.png' />
<#else><#-- GB -->
  <#assign footerHomeImg = '/images/international/GB/Footer_Home.png' />
</#if> 

<h2 class="sectionHeader center">
  <a href = "http://${thisUrl}${.globals.ipTestA}" >
    <img src="${footerHomeImg}" ></img>
  </a>
</h2>

<#include "/footer.ftl"/>

</div><#-- scroller -->

</div><#-- container -->

<script type="text/javascript">
  var doorsTopMenuButton=document.getElementById("menuLink");
  var doorsDropdown=document.getElementById("dropdown");
  var doorsContainer=document.getElementById("container");
  var doorsHeader=document.getElementById("dropdownHeader");
  var doorsBody=document.body;
  var browserName = navigator.userAgent;
  var BB = browserName.indexOf("BlackBerry"); 
  var NOKIA = browserName.indexOf("NOKIA"); 
  
  var dropdownToggle=function() {
    if(doorsTopMenuButton.className==="menuLink menuLinkDE" || doorsTopMenuButton.className=="menuLink menuLinkMulti") {
        doorsTopMenuButton.className="menuLink ${langMenuButton} menuActive";
        doorsDropdown.className="dropdown";
        doorsContainer.className="dropdownHide";
        doorsHeader.className="dropdownHeaderActive dropdownHeader";
        doorsBody.className="background_menu"; //TODO now not working
        if( BB > 0 ) {
               doorsBody.css({"height":"130%"});
        } else if ( NOKIA > 0 ) {
               doorsBody.css({"height":"115%"});
        } else {
        }
    }
    else {
        doorsTopMenuButton.className="menuLink ${langMenuButton}";
        doorsDropdown.className="dropdown dropdownHide";
        doorsContainer.className="";
        doorsHeader.className="dropdownHide dropdownHeader";
        doorsBody.className="";
    }
  }
</script>