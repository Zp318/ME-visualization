<template>
  <div id="app">
    <div v-loading.fullscreen.lock="$store.state.loadingMask"></div>
    <header>
     <div class='LeftImg'>
      <!-- <img src="/ETLManager/static/image/logo.png"/> -->
      <img src="static/image/logo-w.png"/>
      <!-- <img src="/me/static/image/logo-w.png"/> -->
     </div>
     <div class="LoginUser">
       <span class="circle"></span>
       <span class="user">{{user}}</span>
        <a :href="aUrl"><i class="el-icon-upload2" style="cursor: pointer;"></i></a>
     </div>
    </header>
    <div class="content">
      <MEleft></MEleft>
      <iFame></iFame> 
    </div>
     <div class="Wholemask" v-if="$store.state.isMask"></div> 
     
 </div>

</template>
<script>

import MEleft from './components/MEleft/MEleft.vue'
import iFame from './components/MEright/ifame.vue'


 export default {
  components:{
    MEleft,iFame
  },
  data(){
    return {
      user:"Admin",
      aUrl:'j_security_logout'
    }
  },
  computed:{
     
  },
 created(){ 
 
  },
  mounted(){
    
    
  },
  methods:{
 
  }
 } 
</script>


