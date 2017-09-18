define(["jquery"],function($){
   var html = "<div :class='[classA,(showToolFlag ? classB : undefined)]'>" +
        "<span @click='showTool' class='toolBar'></span><ul v-if='showToolFlag'>" +
        "<li @click.stop='top' class='tool-top'></li>"+
        "<li @click.stop='view' class='tool-view'></li>"+
        "<li @click.stop='up' class='tool-up'></li>"+
        "<li @click.stop='down' class='tool-down'></li>"+
        "</ul>"+
        "</div>";
    return {
        template:html,
        props:["index"],
        data:function(){
            return{
                showToolFlag:false,
                "classA":"panel-tool",
                "classB":"panel-tool-bg"
            }
        },
        methods:{
            showTool:function(){
                this.showToolFlag = !this.showToolFlag;
            },
            top:function(){
                this.$dispatch('toolTop',this.index);
                this.$dispatch('leave');
            },
            view:function(){
                this.$dispatch('toolView',this.index);
            },
            up:function(){
                this.$dispatch('toolUp',this.index);
                this.$dispatch('leave');
            },
            down:function(){
                this.$dispatch('toolDown',this.index);
                this.$dispatch('leave');
            }
        }
    }
});