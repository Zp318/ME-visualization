<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cdsf.webmvc.RuntimeContext"%>
<%
String path = request.getContextPath();
String casClient=RuntimeContext.get("cas.client",
		String.class, RuntimeContext.SCOPE_CONFIG);
String casServer=RuntimeContext.get("cas.server",
		String.class, RuntimeContext.SCOPE_CONFIG);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<title>大数据平台</title>
	<link rel="shortcut icon" href="./img/favicon.ico" />
    <link rel="stylesheet" href="css/index.css"/>
</head>
<body>
<div class="clock">
    <div class="clock-day"></div>
    <div class="clock-week"></div>
    <div class="clock-hour"></div>
    <div class="clock-minute"></div>
</div>
<div class="login-entry"></div>
<div class="login-panel" style="display: none;">
    <div class="login-container">
        <div class="login-box">
            <!-- <div class="login-box-bac">
                <div class="login-title">大数据会员登录</div>
                <div class="login-userName">
                    <input placeholder="账号" autocomplete="off" type="text" name="username" />
                </div>
                <div class="login-password">
                    <input placeholder="密码" autocomplete="off" type="password" name="password" />
                </div>
                <div class="login-btn">登&nbsp;&nbsp;&nbsp;&nbsp;录</div>
            </div> -->
        </div>
    </div>
    <div class="closePanel"></div>
</div>
<div class="copyRight">copyright 2016-2017 成都四方伟业软件股份有限公司 版权所有 蜀ICP备14024109号-1</div>
<script type="text/javascript" src="js/lib/jquery.js"></script>
<script type="text/javascript" src="js/lib/jquery.mousewheel.js"></script>
<script type="text/javascript" src="js/lib/three/three.js"></script>
<script type="text/javascript" src="js/lib/three/TrackballControls.js"></script>
<script type="text/javascript" src="js/lib/three/CSS2DRenderer.js"></script>
<script type="text/javascript" src="js/lib/three/CSS3DRenderer.js"></script>
<script type="text/javascript" src="js/lib/three/Projector.js"></script>
<script type="text/javascript" src="js/lib/three/CanvasRenderer.js"></script>
<script type="text/javascript" src="js/lib/three/tween.min.js"></script>
<script type="text/javascript" src="js/lib/three/stats.min.js"></script>
<script>
    $(function(){
        var camera1, scene, renderer,particles=[];

        var scene2, renderer2,group,camera;

        var renderer3,scene3;

        var controls;

        var objects1 = [];

        var elements = [],elements2=[];


        var table = [];
        var table2 = [];

        var sceneY = -60;

        var windowHalfX = window.innerWidth / 2;
		var windowHalfY = window.innerHeight / 2;
		var mouseX = 0;
		var mouseY = 0;

		var listSystemData = null;

        /* var stats; */

        init();

        animate();

        function makeParticles(){

            var particle,material;
            //粒子从Z轴产生区间在-1000到1000
            for(var zpos=-1000;zpos<1000;zpos+=20){
                material = new THREE.SpriteMaterial( {
                    map: new THREE.CanvasTexture( generateSprite()), blending: THREE.AdditiveBlending} );

                particle = new THREE.Particle(material);
                particle.position.x = Math.random()*1000-500;
                particle.position.y = Math.random()*1000-500;
                particle.position.z = zpos;
                particle.scale.x = particle.scale.y = 10;
                scene.add(particle);
                particles.push(particle);
            }
        }



        //移动粒子的函数
        function updateParticles(){
            for(var i=0; i<particles.length; i++){
                particle = particles[i];
                particle.position.z +=  10 * 0.1;
                if(particle.position.z>1000){
                    particle.position.z-=2000;
                }
            }
        }
        function generateSprite() {

            var canvas = document.createElement( 'canvas' );
            canvas.width = 16;
            canvas.height = 16;

            var context = canvas.getContext( '2d' );
            var gradient = context.createRadialGradient( canvas.width / 2, canvas.height / 2, 0, canvas.width / 2, canvas.height / 2, canvas.width / 2 );
            gradient.addColorStop( 0, '#cccccc' );
            gradient.addColorStop( 0.2, '#cccccc' );
            gradient.addColorStop( 0.4, 'rgba(0,0,10,1)' );
            gradient.addColorStop( 1, 'rgba(0,0,0,1)' );

            context.fillStyle = gradient;
            context.fillRect( 0, 0, canvas.width, canvas.height );

            return canvas;

        }

        function init() {

            camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 1500 );
            camera.position.set( 0, 0, 1150 );

            camera1 = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 1500 );
            camera1.position.set( 0, 0, 1200 );

           /* controls = new THREE.TrackballControls( camera );*/
            /* stats = new Stats();
            document.body.appendChild( stats.dom ); */

            scene = new THREE.Scene();
            /*scene.position.set(0,0,0);*/
            scene2 = new THREE.Scene();
            scene3 = new THREE.Scene();

            //加载三个圆




           /* var bac = document.createElement( 'div' );
            bac.style.width = "1920px";
            bac.style.height =  "900px";
            bac.style.background = "url(img/bac2.png) no-repeat";

            /!*var bac1 = document.createElement( 'div' );
            bac1.id = "bac";
            bac1.style.width = "1920px";
            bac1.style.height =  "1920px";
            bac1.style.background = "url(img/bac3.png) no-repeat";
            bac.appendChild(bac1);*!/
            /!*bac.style.backgroundSize = "100%";*!/
            var bacObj = new THREE.CSS2DObject(bac);
            bacObj.position.x = 0;
            bacObj.position.y = 0;
            bacObj.position.z = 0;
            scene3.add( bacObj);*/
            var texture_placeholder = document.createElement( 'canvas' );
            //加载星空背景
            function loadTexture( path ) {

				var texture = new THREE.Texture( texture_placeholder );
				var material = new THREE.MeshBasicMaterial( { map: texture, overdraw: 0.5 } );

				var image = new Image();
				image.onload = function () {

					texture.image = this;
					texture.needsUpdate = true;

				};
				image.src = path;

				return material;

			}
            var materials = [
					loadTexture( 'img/texture_01.jpg' ), // right
					loadTexture( 'img/texture_02.jpg' ), // left
					loadTexture( 'img/texture_03.jpg' ), // top
			];


            /* var texture = new THREE.Texture( texture_placeholder );
            var material = new THREE.MeshBasicMaterial( { map: texture} );
            var image = new Image();
            image.src = "img/bac4.jpg";
            image.onload = function () {
                texture.image = this;
                texture.needsUpdate = true;
            }; */
            //var PlaneGeometry = new THREE.PlaneGeometry( 2800, 1300);
            var mesh1 = new THREE.Mesh(new THREE.PlaneGeometry( 933, 1300, 0, 3, 3, 3 ), materials[0] );
            mesh1.position.x=-933;
            var mesh2 = new THREE.Mesh(new THREE.PlaneGeometry( 933, 1300, 0, 3, 3, 3 ), materials[1] );
            var mesh3 = new THREE.Mesh(new THREE.PlaneGeometry( 933, 1300, 0, 3, 3, 3 ), materials[2] );
            mesh3.position.x=933
            scene.add( mesh1 );
            scene.add( mesh2 );
            scene.add( mesh3 );

            var circle1 = document.createElement( 'div' );
            circle1.style.width = '660px';
            circle1.style.height = '660px';
            circle1.style.opacity = 1;
            circle1.style.background = "url(img/3.png) no-repeat";
            elements.push(circle1);
            var scObj1 = new THREE.CSS3DObject(circle1);
            scObj1.position.x = 0;
            scObj1.position.y = sceneY;
            scObj1.position.z = 0;
            scene2.add( scObj1);
            objects1.push(scObj1);



            var circle2 = document.createElement( 'div' );
            circle2.style.width = '660px';
            circle2.style.height = '660px';
            circle2.style.opacity = 1;
            circle2.style.background = "url(img/2.png) no-repeat";
            elements.push(circle2);
            var scObj2 = new THREE.CSS3DObject(circle2);
            scObj2.position.x = 0;
            scObj2.position.y = sceneY;
            scObj2.position.z = 0;
            scene2.add( scObj2);
            objects1.push(scObj2);

            var circle3 = document.createElement( 'div' );
            circle3.style.width = '660px';
            circle3.style.height = '660px';
            circle3.style.opacity = 1;
            circle3.style.background = "url(img/4.png) no-repeat";
            elements.push(circle3);
            var scObj3 = new THREE.CSS3DObject(circle3);
            scObj3.position.x = 0;
            scObj3.position.y = sceneY;
            scObj3.position.z = 0;
            scene2.add( scObj3);
            objects1.push(scObj3);

            //加载logo
            var logo = document.createElement( 'div' );
            logo.style.width = '256px';
            logo.style.height = '110px';
            logo.style.opacity = 1;
            logo.style.background = "url(img/appLogo3_03.png) no-repeat";
            //elements.push(logo);
            var logoObj = new THREE.CSS3DObject( logo );
            logoObj.position.x = 0;
            logoObj.position.y = sceneY;
            logoObj.position.z = 0;
            objects1.push(logoObj);
            scene2.add(logoObj);

            //加载6个小圆
            listSystemData = null;
            $.ajax({async:false,type:"post",data:{pbl:1},url:"/portal/public/rs/listSystem.json",success:function(json){
        		 listSystemData = json;
            }});

           table = [
        	   {id:"13",title:"数据汇集",icon:"kshpt",nav:{
                   name:"数据汇集",
                   icon:"type2",
                   detail:"基于大数据采集平台，负责将分布的、异构数据源中的数据进行抽取、清洗、转换、集成，实现数据的整合，把数据转换成信息、知识，为报表展示、联机分析、数据挖掘奠定基础。",
                   children:[{name:"批量采集",detail:"提供存储过程、触发器、脚本、Sql等方式的批量采集能力；并可对Oracle、Mysql、SQLServer等的数据库日志进行分析，数据库日志级别的增量数据抽取，节省数据抽取时间。"},
                             {name:"实时采集",detail:"提供实时消息流、消息队列等实时采集能力，通过实时采集数据，能够更好的监控，提炼出所积累的有价值的数据进行实时评估、决策和处理，对问题的产生和预防达到事半功倍的效果。"},
                             {name:"网络爬虫",detail:"根据业务需求，可对网络进行定向抓取，海量检索的爬虫抓取能力；可自动抓取网页的各类参数和下载过程的各类参数。"},
                             {name:"丰富的组件",detail:"支持40多种主流数据库采集，30多种数据文件格式， 20种清洗组件。全过程拖拽组件，快速配置组件参数，灵活的调度机制和可视化的运行效果。"},
                             {name:"跨平台",detail:"支持云平台、Windows、Linux、Unix等主流操作系统厂商的运行环境；平台移植性高，大大降低了部署成本，并可对多终端的数据进行同步和协调。"},
                             {name:"集群及高可靠性",detail:"对节点提供可扩展性，增强集群的整体性能。支持错误恢复机制，通过错误的重定向，保证每个执行任务的有效完成。"}]
               }},
                {id:"16",title:"大数据治理",icon:"sjjh",nav:{
                    name:"大数据治理平台",
                    icon:"type1",
                    detail:"基于大数据基础平台将分散的、多样化的核心主数据通过标准化建立、质量清洗、审核、监控等操作，形成企业和政府部门内的数据管控体系，帮助企业有效挖掘数据价值，提高市场竞争力。",
                    children:[{name:"行业标准规范管理",detail:"针对数据中心的数据结构建立标准，制定校验标准、开放标准、访问标准、技术标准等。"},
                              {name:"可视化建模设计",detail:"支持可视化拖拽方式，对多种类型的数据库进行物理建模；支持从多元数据库中读取已有表，并配置表关系。"},
                              {name:"全景化信息开放与检索",detail:"支持主题的数据台账；基于元数据的信息管理，提供3D数据资源目录与导航；多渠道的数据访问机制（Hadoop、Hbase、API、Webservices）。"},
                              {name:"全生命周期管理",detail:"支持从数据标准建立，数据质量治理，数据资产管理，数据分析整个全生命周期的数据管理能力；提供数据标准梳理工具，使得元数据更合规；支持策略集的质量巡检方式，保障数据的完整性；建立数据治理规范体系，形成治理趋势分析。"}
                    ]
                }},
                {id:"26",title:"SDC Hadoop",icon:"kshpt",nav:{
                    name:"SDC Hadoop",
                    icon:"type2",
                    detail:"融合大数据存储、计算、管理、查询、运维、调度于一体。",
                    children:[{name:"拖拽式流程设计",detail:"灵活的拖拽操作让用户可以按照流程图方式快速创建并管理可视化的大数据应用作业。"},
                              {name:"丰富的流程控件",detail:"提供了Hive、Spark、MR、Shell、邮件、Java程序等丰富控件，实现功能涵盖查询、清洗、计算等。"},
                              {name:"分布式实时搜索",detail:"提供分布式实时搜索与分析引擎，实现海量数据实时搜索并支持多维度的数据展现形态。"},
                              {name:"运维管理",detail:"提供图形化管理界面，支持智能部署、集群安装、服务监控、主机监控、统一告警、性能调优、无宕机升级等，在可管理性方面优势显著。"}]
                }},
                {id:"25",title:"共享服务平台",icon:"znyw",nav:{
                    name:"共享服务平台",
                    icon:"type4",
                    detail:"以信息服务技术为支撑，主要提供轻量级的服务集成、管理、服务调用功能，实现基于授权的数据服务调用，以适应不同单位之间信息共享与服务支撑的需要。",
                    children:[{name:"轻量级服务集成",detail:"基于微服务架构，提升服务开发效率，使服务注册，服务调用等工作变得简单，操作简洁易用；服务接入规范、简单，灵活的扩展，新的服务可以快速接入。"},
                              {name:"零编码",detail:"针对数据服务接口通过web界面即可完成服务发布、审核、共享，无需编程人员开发代码。"},
                              {name:"跨平台无缝衔接",detail:"快速实现跨平台的业务联动和协同， 实现各类资源共享应用，优化和提高各平台资源的管理、使用效率。提供统一的服务管理，确保异构系统之间服务的接入与整合，按需、灵活地进拓展应用、共享信息。"},
                              {name:"服务自动推送",detail:"通过门户申请服务，设置推送频率，可自动向申请节点推送所需要的数据。"},
                              {name:"数据安全、可靠",detail:"通过加密、脱敏等技术，对共享数据进行加工处理，敏感数据更加安全，可靠。"}]
                }},
                {id:"27",title:"数据洞察",icon:"znfx",nav:{
                    name:"数据洞察",
                    icon:"type2",
                    detail:"一个大数据交互式探索和分析的平台,随时为用户提供数据、图形和分析结果三方面的内容，便于用户发现异常数据及包含在数据中的模式或规律。",
                    children:[{name:"实时高效",detail:"基于自研的实时的分布式交互分析引擎SAE底层提供交互式的查询分析及多维分析能力。"},
                              {name:"应用灵活",detail:"基于SOA和微服务思想，平台具有模块化、松耦合、可扩展 。"},
                              {name:"简单易用",detail:"友好的人机交互界面，简单的拖拽操作，直观的分析结果呈现。"}
                              ]
                }},
                {id:"15",title:"人工智能",icon:"rgzn",nav:{
                    name:"人工智能",
                    icon:"type3",
                    detail:"提供挖掘算法库、自定义算法接口及可视化的模型训练界面。",
                    children:[{name:"可视化的模型设计",detail:"自由拖拽算法组件，快速配置组件参数，灵活测试运行效果，图形化评估模型结果。"},
                              {name:"并行化内存计算",detail:"利用分布式并行处理，以强大的内存计算为支撑，提供开发便捷、性能卓越的大数据挖掘能力。"},
                              {name:"丰富的算法组件",detail:"针对模型训练各个环节如数据预处理、机器学习、评估开发了丰富的组件，帮助用户一站式完成模型训练。"},
                              {name:"灵活的自定义算法",detail:"支持用户按照开放的接口规范自由上传和发布自定义算法作为模型训练的组件灵活使用。"}]
                }},
                {id:'03',title:"可视化平台",icon:"kshpt",nav:{
                    name:"大数据可视化平台",
                    icon:"type4",
                    detail:"产品基于“业务主导的自服务模式（Business-User-Driven）”的设计理念，将用户业务体系内部各类多源、异构、海量的数据以图形的方式呈现出来，让抽象的数据变得具象、直观，帮助用户更快地理解数据，为大脑减负，使用户从繁杂的数据分析中解放出来，更加专注于自有业务，使决策更具时效性和高回报性。",
                    children:[
                       {name:"丰富的可视化效果",detail:"强大的数据呈现和表达能力，同一种数据，多元化的呈现，实现不一样的精彩。"},
                       {name:"交互式探索分析",detail:"丰富的交互组件，强大的多维分析，支持图表之间、页面之间的多样化事件联动、参数传递，事件动作灵活配置。"},
                       {name:"多数据源整合",detail:"支持主流的RDBMS（关系型数据库）、Excel/CVS、分析型数据集市、及其他JDBC数据源，能与基于Hadoop的大数据平台产品无缝衔接。"},
                       {name:"极致的用户体验",detail:"以WebGL技术为支撑，提供硬件3D加速渲染，通过智能语音控制3D模型数据实时动态绘制。"},
                       {name:"智能跨屏",detail:"分辨率自适应，支持手机端、平板电脑、LED大型显示屏等多种展示媒介。"}
                    ]
                }}
                ];

            //table 数据加载顺序调整
            table = table.reverse();
            group = new THREE.Group();

            //要显示就删除这个代码
            listSystemData.data = listSystemData.data.filter(function(v,i){
            	return v.flowId != "01";
            });
			if(listSystemData.data){
				var ld = listSystemData.data;
				//对list排序，按table的顺序
				var temps=[];
				
				for(var i=0;i<table.length;i++){
					for(var j=0;j<ld.length;j++){
						if(table[i].id==ld[j].flowId){
							temps[i]=ld[j];
							break;
						}
					}
				};
				listSystemData.data=temps;
				ld=temps;

				for(var i = 0,l = ld.length; i < l ; i++ ){
	                (function(i){
	                    var hudu = (2*Math.PI / 360) * (360/(l));
	                    var x =  0 + Math.sin(hudu*(i+1)) * 320;
	                    var y =  0 - Math.cos(hudu*(i+1)) * 320;
                        var tableObj = returnTableObj();
                        function returnTableObj(){

                                for(var key in table){
                                        if(ld[i].flowId == table[key].id){
                                                return table[key];
                                        }
                                }
                        }
                        if(!tableObj){
                                alert("与后台Id不匹配，请修改对应主页平台id值为:"+ld[i].flowId);
                                return false;
                        }




	                    var element = $("<div class='"+tableObj.icon+" roundBall "+(i%2 == 0 ? "odd":"even")+"'></div>");

	                    table2.push(tableObj.nav);
                        elements2.push(element);

                        var icon = $("<div class='icon "+tableObj.icon+"'></div>");
                        var details = $("<div class='details'></div>").html(ld[i].subTitle);
                        var ballCirc1 = $("<div class='ballCircle1'></div>");
                        var ballCirc2 = $("<div class='ballCircle2'></div>");
                        element.append(icon);
                        element.append(ballCirc1);
                        element.append(ballCirc2);
                        element.append(details);

	                    elements.push(element.get(0));
	                    var object = new THREE.CSS3DObject(element.get(0));

	                    object.position.x = x;
	                    object.position.y = y;
	                    object.position.z = 1;
	                    object.rotation.z = 4.6;

	                    group.add(object);
	                })(i);
	            }
			}

            $(elements2).each(function(i,v){
                v.on("click",function(){
                    change(i);
                    new TWEEN.Tween(logoObj.position)
                            .to( {y:-550,z:-500}, 1000)
                            .easing(TWEEN.Easing.Back.InOut)
                            .start();
                })
            });

            group.position.y = sceneY;
            group.rotation.z = -4.6;
            scene2.add(group);
            objects1.push(group);


            makeParticles();
            renderer = new THREE.CanvasRenderer();
            renderer.setClearColor( 0x13192F);

            renderer.setPixelRatio( window.devicePixelRatio );
            renderer.setSize( window.innerWidth, window.innerHeight );
            document.body.appendChild( renderer.domElement );

            renderer2 = new THREE.CSS3DRenderer();
            renderer2.setSize( window.innerWidth, window.innerHeight );
            renderer2.domElement.style.position = 'absolute';
            renderer2.domElement.style.top = 0;
            renderer2.domElement.style.zIndex = 3;
            document.body.appendChild( renderer2.domElement );


            /*renderer3 = new THREE.CSS2DRenderer();
            renderer3.setSize( window.innerWidth, window.innerHeight );
            renderer3.domElement.style.position = 'absolute';
            renderer3.domElement.style.top = 0;
            renderer3.domElement.style.zIndex = -1;
            document.body.appendChild( renderer3.domElement );

            renderer3.render(scene3,camera);*/

            document.addEventListener( 'mousemove', onDocumentMouseMove, false );

            window.addEventListener( 'resize', onWindowResize, false );

        }
        function onDocumentMouseMove( event ) {
			mouseX = ( event.clientX - windowHalfX );
			mouseY = ( event.clientY - windowHalfY ) * 0.2;
		}
        function onWindowResize() {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize( window.innerWidth, window.innerHeight );
            renderer2.setSize( window.innerWidth, window.innerHeight );
            renderer2.render( scene2, camera );

        }

        function change(index){
            for(var i = 0,l = elements.length;i<l ;i ++){
                //elements[i].style.opacity = 0;
                (function(i){
                    $(elements[i]).hide();

                    /*$(elements[i]).animate({
                        opacity:0
                    },1000,function(){
                        $(this).hide();
                    });*/

                })(i)
            }
            init2(index);
        }

        function init2(index){

            var circle = $("<div></div>").css({
                width:"1375px",
                height:"1375px",
                opacity:1,
                background:"url(img/5.png) no-repeat"
            });
            var scObj = new THREE.CSS3DObject(circle.get(0));
            scObj.position.x = 0;
            scObj.position.y = 0;
            scObj.position.z = 500;
            scene2.add( scObj);

            var circle1 = $("<div></div>").css({
                width:"1250px",
                height:"1250px",
                opacity:0.2,
                borderRadius:"100%",
                border:"1px solid white"
            });

            var scObj1 = new THREE.CSS3DObject(circle1.get(0));
            scObj1.position.x = 0;
            scObj1.position.y = 0;
            scObj1.position.z = 500;
            scene2.add( scObj1);

			var curi = index;
			var maxLen = table2.length;
			var minLen = 0;
            //创建右边导航

            $(document).unmousewheel().mousewheel(function(e){
            	if(e.deltaY > 0){
            		curi >=maxLen-1 ? curi :
            			(curi++,switchNav.call(this,curi,table2[curi].children));

            	}else{
            		curi <=minLen ? curi :
            			(curi--,switchNav.call(this,curi,table2[curi].children));
            		;
            	}
            });

            var group = new THREE.Group();

            for(var i = 0,len = table2.length; i < len ;i++){
                (function(i){
                    var nav = $("<div class='nav "+(i>0? "l"+(i > 3? 3 : i):"")+"'></div>").on("click",function(){
                    	if(curi == i)return;
                    	curi = i;
                    	switchNav.call(this,i,table2[i].children);
                    });
                    var navItem  = $("<div class='navItem'>" +
                            "<i class='"+table2[i].icon+"'></i>" +
                            "<div class='line'></div>"+
                            "<div class='content'>" +
                            "<div class='title'>"+listSystemData.data[i].name+"</div><div class='info'>" +
                            table2[i].detail+"</div>"+
                            "</div>"+
                            "</div>");
                    nav.append(navItem);

                    var object = new THREE.CSS3DObject(nav.get(0));
                    object.rotation.z = i/10*3;
                    group.add(object);
                })(i);
            }
            group.position.z = 500;
            scene2.add(group);
            new TWEEN.Tween(scObj.position)
                    .to( {z:0}, 1000)
                    .easing(TWEEN.Easing.Sinusoidal.Out)
                    .start();
            new TWEEN.Tween(scObj1.position)
                    .to( {z:0}, 1000)
                    .easing(TWEEN.Easing.Sinusoidal.Out)
                    .start();
            new TWEEN.Tween(group.position)
                    .to( {z:0}, 1000)
                    .easing(TWEEN.Easing.Sinusoidal.Out)
                    .start();
            switchNav(index,table2[index].children);
            function switchNav(i,data){
                var update = 0;
                var step = i > 0 ? -i : i;
                new TWEEN.Tween(group.rotation)
                        .to( {z:step/10*3}, 500)
                        .easing(TWEEN.Easing.Quadratic.InOut)
                        .start().onUpdate(function(){
                            if(update < 2){
                                $(".nav").each(function(ii){
                                    /(l\d+)/.test($(this).attr("class"));
                                    switch (ii-i>0){
                                        case true:{
                                            $(this).removeClass(RegExp.$1);
                                            $(this).addClass("l"+(ii-i > 3 ? 3 : ii-i));
                                            break;
                                        }
                                        case false:{
                                            if(ii-i == 0){
                                                $(this).removeClass(RegExp.$1);
                                                break;
                                            }
                                            $(this).removeClass(RegExp.$1);
                                            $(this).addClass("l"+(i-ii > 3 ? 3 : i-ii));
                                        }
                                    }
                                });

                            }
                            update++;
                        });
                new TWEEN.Tween(scObj.rotation)
                        .to( {z:step/10*3}, 500)
                        .easing(TWEEN.Easing.Quadratic.InOut)
                        .start();
                initList(data,listSystemData.data[i])
            }

            var listObj;
            var enterObj;
            var list;
            function　initList(data,data2){
                if(listObj){
                    var lastScene = scene2;
                    var lastListObj = listObj;
                    scene2.remove(enterObj);
                    var listLen1 = list.find("li").size();
                    list.find("li").each(function(i,v){
                        var left = listLen1 < 5 ?
                        		["-260px","-190px","-260px","-190px"]
                        		:
                        		["-305px","-140px","-400px","-170px","-280px","-110px"];
                        $(this).animate({
                            opacity:0,
                            left:left[i]
                        },500,function(){
                            lastScene.remove(lastListObj);
                        });
                    });
                }
                if(!data)return;
                list = $("<div class='list'></div>");
                var ul = $("<ul></ul>");
                var li = [];
                for(var i = 0,l = data.length; i<l; i++){
                	var type =l < 5 ? "type" : "type_1_";
                    var str = "<li style='left:-450px;opacity:0' class='"+type+(i+1)+"'>" +
                        "<i><div></div></i>"+
                        "<div class='list-content'>" +
                        "<div class='list-title'>"+data[i].name+"</div>"+
                        "<div class='list-info'>"+data[i].detail+"</div>"+
                        "</div>"+
                        "</li>";
                    li.push(str);
                }
                ul.append(li.join(""));
                list.append(ul);
                listObj = new THREE.CSS3DObject(list.get(0));
                scene2.add(listObj);
                var listLen2 = list.find("li").size();
                list.find("li").each(function(i,v){
                    var left = listLen2 < 5 ?
                    		["-310px","-250px","-310px","-240px"]
                    		:
                    		["-325px","-160px","-420px","-190px","-300px","-100px"];
                    $(this).delay(i*150).animate({
                        left:left[i],
                        opacity:1
                    });
                });
                var enter = $("<a href='javascript:void(0);'  class='enter'></a>");
                enter.click(function(){
                	handleClick(data2.accessUrl)
                });
                enterObj = new THREE.CSS3DObject(enter.get(0));
                scene2.add(enterObj);
            }

        }


        function transform(){
            TWEEN.removeAll();
        }
        
        function handleClick(url){
        	var redirecturl='<%=path%>/static/redirect.jsp';
            var url =redirecturl + "?skipTo=" + encodeURIComponent(url);
            window.location.href=url;
        }
      

        function animate() {
        	//console.log(mouseX - camera.position.x);
        	camera1.position.x += ( mouseX/5 - camera1.position.x ) * 0.05;
			camera1.position.y += ( - mouseY - camera1.position.y ) * 0.05;
			camera1.lookAt(scene.position);

            requestAnimationFrame( animate );
            TWEEN.update();
            /*controls.update();*/
            renderer.render( scene, camera1 );
            /* stats.begin();
            stats.end(); */
            updateParticles();
            renderer2.render( scene2, camera );
        }

        //时间
        function clock(){
            var date =  new Date();
            var month = date.getMonth()+1;
            var week = date.getDay();
            var day = date.getDate();
            var hour = date.getHours();
            var minute = date.getMinutes();
            switch (week) {
                case 1: week = "MONDAY"; break;
                case 2: week = "TUESDAY"; break;
                case 3: week = "WEDNESDAY"; break;
                case 4: week = "THURSDAY"; break;
                case 5: week = "FRIDAY"; break;
                case 6: week = "SATURDAY"; break;
                case 7: week = "SUNDAY"; break;
            }
            document.getElementsByClassName("clock-day")[0].innerHTML = (month<10 ? "0"+month:month) +"." + (day<10?"0"+day:day);
            document.getElementsByClassName("clock-week")[0].innerHTML = week;
            document.getElementsByClassName("clock-hour")[0].innerHTML = hour<10?"0"+hour:hour;
            document.getElementsByClassName("clock-minute")[0].innerHTML = minute<10?"0"+minute:minute;
        }
        clock();
        setInterval(clock,1000);


        $(".login-entry").on("click",function(){
        	$(".login-panel").show();
        	$(".login-box").append("<iframe id='login-ifm' border='0'></iframe>")
        	$("#login-ifm").attr("src","<%=casServer%>/cas/login?loginType=3&service="+encodeURIComponent('<%=casClient%>/portal/')).css({
        		width:$(window).width(),
        		height:$(window).height()
        	});


        });
        $(".closePanel").on("click",function(){
            $(".login-panel").hide();
        });
    });
</script>
</body>
</html>
