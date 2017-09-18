<template>
	<div class="MErightVersion">
  <!-- 打包环境 -->
	<!-- 	 <iframe id="rightFrame" name="rightFrame" :src="$store.state.isSrc" frameborder="0" width="100%" height="100%" scrolling="no" marginheight="0" marginwidth="0" style="border:1px solid #CCC; margin:0; padding:0;"></iframe>  -->
     <!-- 生产环境版本管理显示-->
      <MErightVersion v-if="$store.state.isShow"></MErightVersion>
      <!-- 生产环境项目资源管理显示 -->
      <Project v-else></Project>
	</div>
</template>

<script>
import MErightVersion from './version/MErightVersion.vue'
import Project from './project/Project.vue'
 export default {
   components:{
    MErightVersion,Project
  },
  data(){
    return {
    }
  },
 created(){ 
   console.log(this.isShowVersion)
  },
  mounted(){
    
    
  },
  methods:{
  }
 } 
</script>