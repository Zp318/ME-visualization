define(['vue','jquery',"app/panel/panel","app/setting/index","app/expList/list"],function(Vue,$,panel,setting,list){
    var html = "<div v-on:click='clickBody' class='bodyContainer'>" +
        "<template v-for='item of data'>" +
            "<panel-box v-if='item.isEnable' transition='room'  v-bind:data='item' :index='$index'></panel-box>"+
        "</template>"+
        "<setting-box :settingshow='settingshow' :data='data'></setting-box>"+
        "<exp-list :data='data'></exp-list>"+
        "</div>";
    return {
        template:html,
        props:["data","settingshow"],
        attached:function() {
            var self = this;
            /*setInterval(function () {
                self.data.push({title:"11",subTitle:"2312"});
            },1000);*/
        },
        methods:{
            clickBody:function(){
                this.$dispatch('settingBox',0);
            }
        },
        components:{
            panelBox:panel,
            settingBox:setting,
            expList:list
        }
    }
});