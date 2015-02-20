<@editor.page title="${site.name}" showheader=false showfooter=false>
<style>
.touchslider .touchslider-viewport {
    background: none repeat scroll 0 0 #FFF1E0;
    border: 5px solid #FFF1E0;
    border-radius: 6px 6px 6px 6px;
}
.touchslider .touchslider-item {
    height: 400px;
    overflow: hidden;
}
.touchslider .touchslider-nav {
    margin-top: 16px;
    text-align: center;
}
.touchslider .touchslider-nav a {
    color: #000000;
    cursor: pointer;
}
.touchslider .touchslider-nav a:active {
    background: none repeat scroll 0 0 #689DB2;
}
.touchslider-nav {
    font: bold 16px/16px Georgia;
}
.touchslider .touchslider-prev {
    background: none repeat scroll 0 0 #FFFFFF;
    border-radius: 12px 0 0 12px;
    display: inline-block;
    height: 16px;
    margin-right: 16px;
    padding: 0 0 0 10px;
    position: relative;
    width: 100px;
}
.touchslider .touchslider-next {
    background: none repeat scroll 0 0 #FFFFFF;
    border-radius: 0 12px 12px 0;
    display: inline-block;
    height: 16px;
    margin-left: 16px;
    position: relative;
    width: 100px;
}
.touchslider .touchslider-next-in {
    position: absolute;
    right: 10px;
}
.touchslider .touchslider-prev-in {
    left: 10px;
    position: absolute;
}
.touchslider .touchslider-nav-item {
    background: none repeat scroll 0 0 #FFFFFF;
    border-radius: 12px 12px 12px 12px;
    display: inline-block;
    height: 16px;
    margin: 0 16px;
    width: 16px;
}
.touchslider .touchslider-nav-item-current {
    background: none repeat scroll 0 0 #CFF0FF;
}
.section-download {
    padding-right: 230px;
    position: relative;
}
.social {
    position: absolute;
    right: 20px;
    top: 0;
    width: 200px;
}
.touchslider-social .touchslider-nav {
    margin-bottom: 6px;
    text-align: center;
}
.touchslider-social .touchslider-nav-item {
    opacity: 0.5;
    padding: 0 2px;
}
.touchslider-social .touchslider-nav-item-current {
    opacity: 1;
}
.div_test {
   width:320px;
   height:400px;
}
.touchslider-viewport {
   width:99%;
   height:400px;
}


/*
@media all and (min-width: 1280px) {
  .div_test {
     width:800px;
     height:400px;
  }
  .touchslider-viewport {
     width:800px;
     height:400px;
  }
  .touchslider .touchslider-item {
     height: 400px;
     overflow: hidden;
  }
}
@media screen and (max-width: 1000px) and (min-width: 500px) {
  .div_test {
     width:500px;
     height:300px;
  }
  .touchslider-viewport {
     width:500px;
     height:300px;
  }
  .touchslider .touchslider-item {
     height: 300px;
     overflow: hidden;
  }
}
*/

@media screen and (orientation:portrait) {
.touchslider-viewport {
   width:97%;
   height:400px;
}
.div_test {
   width:320px;
   height:400px;
}
}
@media screen and (orientation:landscape) {
.touchslider-viewport {
   width:97%;
   height:100px;
}
.div_test {
   width:600px;
   height:200px;
}
}
</style>
<script>
jQuery(function($) {
    $(".touchslider").touchSlider({/*options*/});
});
</script>

<div class="touchslider" style="width:100%;">
    <div class="touchslider-viewport" style="margin:0 auto 0 auto;overflow:hidden;">
    <div>
        <div class="touchslider-item"><div class="div_test" style="background-color:gray;"><a href="http://www.bmw.pl"><img width="75" height="75" alt="Tree and cloud" src="images/74_LRC_App.png"><p>test</p></a></div></div>
        <div class="touchslider-item"><div class="div_test" style="background-color:red;"><img width="75" height="75" alt="Tree and cloud" src="images/74_LRC_App.png"><p>test</p></div></div>
        <div class="touchslider-item"><div class="div_test" style="background-color:yellow;"><img width="75" height="75" alt="Tree and cloud" src="images/74_LRC_App.png"><p>test</p></div></div>
    </div>
    </div>

    <div>
        <span class="touchslider-prev">←</span>
        <span class="touchslider-nav-item touchslider-nav-item-current">1</span>
        <span class="touchslider-nav-item">2</span>
        <span class="touchslider-nav-item">3</span>
        <span class="touchslider-next">→</span>
    </div>
</div>


</@editor.page>