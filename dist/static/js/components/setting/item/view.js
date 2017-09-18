define(function(){
   var html = "<div @click.stop='itemView'></div>";
   return{
       template:html,
       props:["index"],
       methods:{
           itemView:function(){
               this.$dispatch("toolView",this.index);
           }
       }
   }
});