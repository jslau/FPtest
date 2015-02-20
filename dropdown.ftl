<div class="dropdown" id="dropdown">
  <div class="shadow"></div>
  <ul id="dropdown_container">
    <#assign thisUrl=page.request.getServerName()/>
    <li><a href="http://${thisUrl}/" class="doorsDropdownLink">Home</a></li>
    <li><a href="#" class="doorsDropdownLink">News</a></li>
    <li><a href="#" class="doorsDropdownLink">Photos</a></li>
    <li><a href="#" class="doorsDropdownLink">Videos</a></li>
    <li><a href="http://facebook.com/eonline" class="doorsDropdownLink">Facebook</a></li>
    <li><a href="http://mobile.twitter.com/#!/eonline" class="doorsDropdownLink">Twitter</a></li>
    <li><a href="http://${thisUrl}/info.ftl" class="doorsDropdownLink">E! Info</a></li>
  </ul>
</div>