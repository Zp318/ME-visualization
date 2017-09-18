define(["app/setting/item/item"],function(item){
    var html = "<div @click.stop='voidx(0)' class='setting-box' v-show='settingshow' transition='fade'>" +
        "<template v-for='item of data'>" +
        "<item-box :data='item' :index='$index'></item-box>" +
        "</template>" +
        "</div>";
    return {
        template:html,
        props:["settingshow","data"],
        methods:{
            voidx:function(){

            }
        },
        components:{
            itemBox:item
        }
    }
});