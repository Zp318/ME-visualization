define(["app/setting/item/title","app/setting/item/tool","app/setting/item/view"],function(title,toolbar,view){
    var html = "<div @mouseenter='enter' @mouseleave='leave' class='item-box' :class='(index%2==0?classOdd:classEven)'>" +
        "<div class='item'>" +
        "<div class='item-top'><title v-bind:titledata='data' :index='index'></title></div>" +
        "<div class='item-bg'><img style='height: 100%;' :src='data.img'/></div>"+
        "<div class='item-tool' :class='[(itemToolShow && data.isEnable ? animate.itemToolEnter : animate.itemToolLeave )]'>"+
        "<tool :title='data[\"name\"].split(\"|\")[1] || data[\"name\"].split(\"|\")[0]' :index='index'></tool></div>"+
        "<div class='item-view' v-show='!data.isEnable' transition='fade'><item-view :index='index'></item-view></div>"+
        "</div>"+
        "</div>";
    return{
        template:html,
        props:["data","index"],
        data:function(){
            return{
                itemToolShow:false,
                classOdd:{
                    odd:true
                },
                classEven:{
                    even:true
                },
                animate:{
                    "itemToolEnter":"itemTool-enter",
                    "itemToolLeave":"itemTool-leave"
                }
            }
        },
        methods:{
            enter:function(){
                if(!this.data.isEnable){
                    return;
                }
                this.itemToolShow = true
            },
            leave:function(){
                if(!this.data.isEnable){
                    return;
                }
                this.itemToolShow = false
            }
        },
        events:{
            leave:function(){
                this.itemToolShow = false
            }
        },
        components:{
            title:title,
            tool:toolbar,
            itemView:view
        }
    }
});