body {
	font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
	font-size: 14px;
	background-color: #fff;
	
	margin: 2px 0px 0px 0px;
	-webkit-touch-callout: none; 
	-webkit-text-size-adjust: none; 
	-webkit-user-select: none; 
	-webkit-highlight: none; 
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

h1{
	font-size: 5px;
	font-weight: bold;
	color: #0f0f0f;
}

#header{
	
}

#container{
	margin-bottom: 55px;
}

#details{
	background-color: #fff;
	height: 100%;
}
#details-back-arrow{ 
	margin-top: 3px;
	margin-left: 3px;
	float: left;
}
#details-header{
	height: 37px;
	text-align:center;
	font-weight: bold;
	clear: both;
	background-color:#f3f3f3;
	background-image: linear-gradient(0deg, #f2f2f2, #f2f2f2 50%, transparent 50%);
  	background-size: 100% 1px;
  	background-repeat: no-repeat;
  	background-position: bottom;
}

#details-content{
	margin-top: 7px;
}
.details-stretch{
	height: 50px;
}

.feed-item{	
	height: 47px;
	background-color: #fff;
	background-image: linear-gradient(0deg, #f2f2f2, #f2f2f2 50%, transparent 50%);
	background-size: 100% 1px;
	background-repeat: no-repeat;
	background-position: bottom;
}

h3 {
	font-size: 16px;
	margin: 0px 0px 0px 0px;
	border: 0px 0px 0px 0px;
	padding-top: 3px;
	padding-left: 7px;
}

.feed-item-summary{	
	clear:both;
	padding-top: 4px;
	padding-left: 7px;	
	font-size: 13px;
	margin: 0px 0px 0px 0px;
}

.feed-item-timestamp{
	font-size: 11px;
	font-weight: normal;
	padding-top: 5px;
	padding-right: 20px;
	margin: 0px 0px 0px 0px;
}
.feed-item-right{
	height: 100%;
	margin-right: 3px;
	background-image: url( https://logalytics.herokuapp.com/static/img/ios/766-arrow-right.png );
	background-position: right;	
	background-repeat: no-repeat;	
}
.feed-detail-link {
	text-decoration: none;
	color: #0e0e0e;
}

.centered {
  position: fixed;
  top: 50%;
  left: 50%;
  margin-top: -50px;
  margin-left: -15px;
}

.feed-date-separator{
	height: 20px;
	vertical-align: middle;
	padding-top: 4px;
	padding-left: 5px;
	font-size: 15px;
	color: #0e0e0e;
	background-color:#f3f3f3;
	
	background-image: linear-gradient(0deg, #f2f2f2, #f2f2f2 50%, transparent 50%);
  	background-size: 100% 1px;
  	background-repeat: no-repeat;
  	background-position: bottom;
}

.last-item{
	text-align:center;
}
.stretch {
	width: 100%;
	display: inline-block;
	font-size: 0;
	line-height: 0
}

red 	{ color: #f00; }
green 	{ color: #0f0; }

/*
Segmented Control Styles
*/
div { display: block; }

.current {
	visibility: visible;
}

.horizontal.centered {
	-webkit-justify-content: center;
	-webkit-align-item: center;
	-webkit-box-pack: center;
	-webkit-box-align: stretch;
}

.horizontal {
	display: -webkit-box;
	-webkit-align-item: start;
	-webkit-box-pack: start;
	-webkit-box-align: start;
	display: -webkit-flex;
	-wekbit-flex-direction: row;
	-webkit-box-orient: horizontal;
	-webkit-justify-content: start;
}

user agent stylesheetdiv {
	display: block;
}

div.horizontal.centered > .segmented {
	display: -webkit-box;
	display: -webkit-flex;
	margin: 10px 15px;
	-webkit-flex: 1;
}
.segmented {
	display: -webkit-inline-box;
	-webkit-box-orient: horizontal;
	display: -webkit-inline-flex;
	-wekbit-flex-direction: row;
	box-sizing: border-box;
}

.segmented > .button:first-of-type {
	border-left: solid 1px #007aff;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px;
}

.segmented > .button {
	border: solid 1px #007aff;
	padding: 4px 15px;
	border-left: none;
	background-color: rgba(255,255,255,.65);
	width: auto;
	overflow-x: hidden;
	-webkit-transition: none;
	transition: none;
	font-size: 10pt;
	-webkit-box-align: center;
	-webkit-box-pack: center;
	-webkit-box-flex: 1;
	-webkit-flex: 1;
	text-align: center;
}
a.button, a.button.back::before {
	color: #007aff;
	border-color: #007aff;
}
a.button {
	cursor: pointer;
	text-decoration: none;
	font-size: 13pt;
	-webkit-transition: all .35s ease-out;
	transition: all .35s ease-out;
	display: block;
	box-sizing: border-box;
	box-sizing: border-box;
	height: auto;
	width: auto;
	padding: 8px 0px;
	position: relative;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	vertical-align: middle;
	text-align: center;
	background-color: rgba(255,255,255,.01);
}

.segmented > .button:hover, .segmented > .button.selected {
	color: #fff;
	background-color: #007aff;
	opacity: 1 !important;
}
.segmented > .button:last-of-type {
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
}

.green-background {
	background-color: #4CD964;
	color: #fff;
}

.red-background {
	background-color: #FF2D55;
	color: #fff;
}

.mobile-btn { 
	height: 32px;	
	text-align: center; 			
	padding-top: 15px;
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 5px;
	margin-right: 5px;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	border-radius: 8px; /* future proofing */
	-khtml-border-radius: 8px; /* for old Konqueror browsers */
}