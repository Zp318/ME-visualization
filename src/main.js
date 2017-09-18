// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './components/vuex/store'
import  VueResource  from 'vue-resource'
import ElementUI from 'element-ui'
// import echarts from 'echarts';
// import moment from 'moment';
// import $ from 'jquery';
import 'element-ui/lib/theme-default/index.css'
import '../static/common/css/common.css'
import '../static/common/css/reset.css'
import '../static/common/css/style.css'
import '../static/css/MEleftNav.scss'
import '../static/css/Version.scss'
import '../static/css/EProject.scss'
import $ from 'jquery';
import '../node_modules/element-ui/lib/theme-default/index.css';
import axios from 'axios'
Vue.prototype.$axios=axios

Vue.use(ElementUI)
Vue.use(VueResource)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})
