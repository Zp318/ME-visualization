define(["jquery","app/panel/panelTool/title","app/panel/panelTool/tool"],function($,title,tool){
    var html = "<div :aim='index' :class='[classA,(index%2==0?classOdd:classEven)]'>" +
        "<div class='panel-top'><title v-bind:titledata='data' :index='index'>" +
        "</title><tool :index='index'></tool></div>" +
        "<div class='panel-center'>" +
        /*"<template v-if='index != 0'>" +*/
        /*"<img :src='data.img' />"+*/
        /*"</template>"+*/
        "<template v-if='data.url'>" +
        "<iframe  style='width: 100%;height: 400px;' :src='data.url' frameborder='0' :id='\"ifm\"+(new Date().getTime())'  onLoad='iframe_load(this,event);'></iframe>"+
        "</template>"
        "</div>" +
        "</div>";
    return {
        template:html,
        props:["data","index"],
        data:function(){
            return {
                classA:"panelBox",
                classOdd:"odd",
                classEven:"even"
            }
        },
        methods:{
        	
        },
        components:{
            title:title,
            tool:tool
        }
    }
});