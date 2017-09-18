<template>
	<div class="MEleft">
  <div class="eltitle">资源管理目录</div>
	 <el-row class="tac">
	  <el-col>
		<el-menu default-active="2" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
		 <el-submenu index="1">
			<template slot="title"><i class="icon-folder-open file"></i><span class="mag">系统管理</span></template>
			<span id="index4"> 
			 <el-submenu index="1-2" >
			  <template slot="title"> <i class="icon-folder-open file"></i><span class="mag">资源管理</span></template>
			  <el-menu-item index="1-2-1" @click="handOpenVersion(true)"><span class="versiongl">版本管理</span></el-menu-item>
			  <el-menu-item index="1-2-2" @click="handOpenVersion(false)"><span class="versiongl">项目资源管理</span></el-menu-item>
			 </el-submenu>
			</span>
		   </el-submenu>
		  </el-menu>
	  </el-col>
	 </el-row>
	</div>
</template>

<script>
 export default {
  data(){
    return {
      user:"Admin",
      sssrc:'http://element.eleme.io/#/zh-CN/component/menu'
    }
  },
 created(){ 
 
  },
  mounted(){
    
    
  },
  methods:{
      handleOpen(key, keyPath) {
      },
      handleClose(key, keyPath) {
         // this.$store.dispatch('setSrc','https:www.baidu.com');
      },
      handOpenVersion(flag,url){
      	this.$store.dispatch('setShow',flag);
      	 // this.$store.dispatch('setSrc','');
      	 // this.$store.dispatch('setSrc',url);
      }
  }
 } 
</script>