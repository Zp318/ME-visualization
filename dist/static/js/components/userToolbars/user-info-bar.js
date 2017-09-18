define(function(){
    var html = "<span @click.stop='info' class='user-info-bar'></span>";
    return {
        template:html,
        methods:{
            info:function(){
                this.$dispatch("showModalFunc");
            }
        }

    }
});