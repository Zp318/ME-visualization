define(function(){
    var html = "<span class='tool-title'>{{title}}</span><ul>" +
        "<li @click.stop='top' class='tool-top'></li>"+
        "<li @click.stop='view' class='tool-view'></li>"+
        "<li @click.stop='up' class='tool-up'></li>"+
        "<li @click.stop='down' class='tool-down'></li>"+
        "</ul>";
    return {
        template:html,
        props:["title","index"],
        methods:{
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