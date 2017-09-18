/**
 * 饼图公共配置项
 * @params text type:String 标题
 * @params legend type:Array  图例
 * @params serieData type:Array  series数据
 * @params option 图表配置项
**/
export function CharPieOption(legend,series){
 var option={
	 	tooltip: {
	        // trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
	 	legend:{
	 		data:legend
	   },
	 	color:["rgb(194,53,49)","rgb(47,69,84)"],
	 	series:[{
		 		type:'pie',
	            radius : '55%',
                center: ['50%', '60%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: true,
	                    formatter: "{d}%",
	                },
	            },
	             labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:series
	 	}]

 };
 return option;
}

/**
 * 图表series设置
 * @params legend type:Array 图例
 * @params series type:Array  series数据
 * @params seriesData 图表配置项
**/
export function createSeries(series){
	var seriesData = [];
	series.map(function(v,i){
		var singleSeries = {
			name: v["name"],
			type: "line",
			barWidth: 2,
			areaStyle: {normal: {}},
			smooth:true,
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
			lineStyle: {
				normal: {
					width: 2
				}
			},
			symbolSize: 4,
			itemStyle: {
				normal: {
					barBorderRadius: [5, 5, 0, 0]
				}
			},
			data: v["data"]
		};
		seriesData.push(singleSeries)
	})
	return seriesData;
}; 

/**
 * 图表公共配置项
 * @params legenData type:Array 图例
 * @params timeData type:Array  横坐标
 * @params serieData type:Array  series数据
 * @params option 图表配置项
**/
export function ChartOption(title,legenData,timeData,serieData){
	var option={
		title:{
			text: title,	
			left:'2%',
			top:'2%',
			textStyle:{
				fontSize:14,
				fontWeight:'lighter',
				color:'#2f4554'

			}
		},
		tooltip:{
			trigger:'axis',
			backgroundColor:'rgba(0,0,0,0.6)',
			axisPointer:{
				lineStyle:{
					color:'#909090',
					width:1
				}
			},
			textStyle:{
				fontSize:14
			}
		},
		legend:{
			data:legenData,
			textStyle:{color:'#a9a9a9',fontFamily:'Microsoft Yahei',fontSize:10},
			top:'2%',
			left:'45%',
			x:'10%',
			y:'top',
			itemWidth: 19,
			itemHeight: 8,
			itemGap:20
		},
		color:['#d45c82','#2dbffb'],
		calculable:false,
		backgroundColor:false,
		xAxis : [
			{
				type : 'category',
				position: 'bottom',
				boundaryGap:false,
				axisLine : {    // 轴线
					show: true,
					lineStyle: {
						color: '#e5e5e5',
						type: 'solid',
						width: 1
					}

				},
				axisTick : {    // 轴标记
					show:false,
					// length: 0.05*REM,
					lineStyle: {
						// color: '#909090',
						type: 'solid',
						width: 1
					}
				},
				axisLabel : {
					show:true,
					interval: 'auto',    // {number}
					// margin:0.1*REM,
					textStyle: {
						color: '#bbb',
						fontFamily: 'Arial',
						fontSize:10
					},
					interval:0,
					rotate:45
				},
				splitLine : {
					show:false
				},
				data : timeData
			}
		],
		yAxis : [
			{
				type : 'value',
				position: 'left',
				axisLine : {    // 轴线
					show: false
				},
				axisTick : {    // 轴标记
					show:false
				},
				axisLabel: {
                     formatter:'{value}%',
                     textStyle: {
						color: '#909090',
						fontFamily: 'Arial',
						// fontSize: 0.12*REM,
						fontStyle: 'normal',
						//fontWeight: 'bold'
					 }
	               },
				splitLine : {
					show:true,
					lineStyle: {
						color: '#909090',
						type: 'solid',
						width: 0.2
					}
				},
				splitArea : {
					show: false,
				}
			}
		],
		series:serieData
	};
	 return option;
}