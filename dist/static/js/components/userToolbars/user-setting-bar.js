define(function(){
    var html = "<span @click.stop='setting' class='user-setting-bar'></span>";
    return {
        template:html,
        methods:{
            setting:function(){
                this.$dispatch('settingBox',1);
            }
        }

    }
});