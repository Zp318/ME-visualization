define(["jquery"],function($){
    var html = "<div class='exp-container' @mouseleave='swapType(1)' @mouseenter='swapType(0)'><div class='overflow'><ul class='exp-list'>"+
        "<template v-for='item of data'>"+
            "<li class='exp-item' @click.stop='scroll($index,$event)' :class='type' v-if='item.isEnable'>" +
            "{{value($index)}}" +
            "</li>"+
            "<li class='exp-line' v-if='($index < data.length-1) && item.isEnable'><span v-if='type.typeB' class='expand-line'></span></li>"+
        "</template>"+
        "</ul></div></div>";
   return{
       template:html,
       props:["data"],
       data:function(){
           return{
               type:{
                   typeA:true,
                   typeB:false
               }
           }
       },
       methods:{
           value:function(index){
               val = "";
               if(this.type.typeA){
                   val = (index+1)<10?'0'+(index+1):(index+1);
               }else{
                   val = this.data[index]["name"].split("|")[1] || this.data[index]["name"].split("|")[0];
               }
               return val
           },
           swapType:function(type){
               var _this = this;
               var f = (type == 1);
               $(".exp-container .overflow").css("width",f ? "auto" :"60px");
               $(".exp-list").stop(true);
               $(".exp-list").animate({
                   "marginLeft":-60 + "px"
               },200,"linear",function(){
                   _this.type.typeA = f;
                   _this.type.typeB = !f;
               });
               $(".exp-list").delay(200).animate({
                   "marginLeft":"0px"
               });
           },
           scroll:function(index){
              var elt = $(".panelBox[aim="+index+"]").offset().top;
              $("html,body").animate({scrollTop:elt-80},"linear");
           }
       },
       attached:function(){
            var wh = $(window).height();
            var h = $(".exp-container").height();
           $(".exp-container").css("top",((wh-h)*1/2) < 80 ? 80 + 5 : ((wh-h)*1/2));
           $(window).unbind("resize.exp").on("resize.exp",function(){
               var wh = $(window).height();
               var h = $(".exp-container").height();
               $(".exp-container").css("top",((wh-h)*1/2) < 80 ? 80 + 5 : ((wh-h)*1/2));
           });
       }
   }

});